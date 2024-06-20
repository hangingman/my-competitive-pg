from langchain.chains.llm import LLMChain
from langchain.chains.sequential import SequentialChain
from langchain.output_parsers import PydanticOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         HumanMessagePromptTemplate,
                                         SystemMessagePromptTemplate)
from langchain_core.output_parsers import StrOutputParser
from langchain.callbacks.tracers import ConsoleCallbackHandler

from CompeteAI.domain.factory.llm_factory import LLMFactory
from CompeteAI.domain.models.algorithm_candidate import AlgorithmCandidates
from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class ProblemSolverAgent:
    def __init__(self, llm: LLMType, handler: StreamHandler = None, tool=None):
        self.tool = tool
        self.llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.default_model_name(),
            temperature=0.8,
        )
        self.func_llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.light_model_name(),
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def solve(self, chatlog: [], streaming: bool = True) -> AlgorithmCandidates:
        # context = self.memory.load_context()
        parser = PydanticOutputParser(
            pydantic_object=AlgorithmCandidates
        )  # 出力用にOutputParserを定義する

        # アルゴリズムの候補を考えるchain
        system_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
あなたはアルゴリズムと数学に長けたアルゴリズム専門家です。
以下の制約条件と問題文をもとに少なくとも3つの実行可能なアルゴリズムを提案してください
それぞれのアルゴリズムについて、以下の情報を提供してください。

1. アルゴリズムの詳細な説明と擬似コード
2. 利点と欠点
3. 最悪計算量（Big-O表記）
4. 具体的なデータサイズ（10^5, 10^6, 10^9）に対する実行時間の推定

# 制約条件:
* 回答は日本語で行うこと
* コードの効率性を最優先し、できるだけ計算量を抑えた解法を提出してください
* 提案されたアルゴリズムは、競技プログラミングコンテストで実行可能であることが求められます, 実行時間の推定は現実的である必要があります
* 擬似コードは自然言語で記載すること
""",
                input_variables=[],
            )
        )
        analysis_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="{analysis}\n{knowledge}\n",
                input_variables=["analysis", "knowledge"],
            )
        )
        problem_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 入力文：\n{problem}""",
                input_variables=["problem"],
            )
        )
        think_prompt = ChatPromptTemplate.from_messages(
            [system_prompt, analysis_prompt, problem_prompt]
        )

        # JSONにフォーマットするchain
        instruction_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
* 以下の制約条件をもとに入力文をJSONに変換せよ
* JSONのみを出力すること、「```json ...<snip>... ```」のような記法は不要
{format_instructions}
""",
                input_variables=["algorithm_candidates"],  # TODO: 上でoutput variableを設定する
                partial_variables={
                    "format_instructions": parser.get_format_instructions()
                },
            )
        )
        algo_candidate_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 入力文：\n{problem}""",
                input_variables=["problem"],
            )
        )

        format_prompt = ChatPromptTemplate.from_messages([instruction_prompt, algo_candidate_prompt])

        llm_input = {
            "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
            "knowledge": get_first_dict_by_key(chatlog, "knowledge")["msg"],
            "problem": get_first_dict_by_key(chatlog, "problem")["msg"],
        }

        if streaming:
            # Streamを使用して出力を逐次処理
            chains = think_prompt | format_prompt | self.llm | StrOutputParser()
            ans: str = "".join(
                [chunk for chunk in chains.stream(input=llm_input, config={'callbacks': [ConsoleCallbackHandler()]})]
            )
            return parser.parse(ans)
        else:
            # 通常の方法で呼び出し
            think_chain = LLMChain(
                prompt=think_prompt,
                output_key="algorithm_candidates",
                llm=self.llm,
                verbose=True,
            )
            format_chain = LLMChain(
                prompt=format_prompt,
                llm=self.func_llm,
                verbose=True,
            )
            chains = SequentialChain(
                chains=[think_chain, format_chain],
                input_variables=["analysis", "knowledge", "problem"],
            )
            ans: dict = chains.invoke(input=llm_input)
            return parser.parse(ans["text"])


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None
