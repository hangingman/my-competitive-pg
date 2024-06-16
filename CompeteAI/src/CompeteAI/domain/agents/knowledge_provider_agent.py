from langchain.chains.llm import LLMChain
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         HumanMessagePromptTemplate,
                                         SystemMessagePromptTemplate)

from CompeteAI.domain.factory.llm_factory import LLMFactory
from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class KnowledgeProviderAgent:
    def __init__(self, llm: LLMType, handler: StreamHandler, tool=None):
        self.tool = tool
        self.llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.default_model_name(),
            temperature=0.3,
        )
        self.memory = CustomMemory(llm=self.llm)

    def solve(self, chatlog: [], streaming: bool = True) -> str:
        # context = self.memory.load_context()

        # アルゴリズムの候補を考えるchain
        knowledge_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
あなたはアルゴリズムと数学に長けたアルゴリズム専門家です。
以下の問題文に関する既存の知識や関連問題を提供してください。

# 観点:
1. 同様の問題を知っているか？
2. 同じ問題を少し違った形で知っているか？
3. 関連する問題を知っているか？
4. 役立ちそうな定理を知っているか？
5. 未知のものに着目し、同じまたは類似の未知のものを持つ、使い慣れた問題について考えよ

# 制約条件:
* 観点５つはグループ分けせず箇条書きで簡潔に文章を提案せよ

# 問題文の分析:
{analysis}
""",
                input_variables=["analysis"],
            )
        )
        problem_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 入力文：\n{problem}""",
                input_variables=["problem"],
            )
        )

        chain = LLMChain(
            prompt=ChatPromptTemplate.from_messages([knowledge_prompt, problem_prompt]),
            llm=self.llm,
            verbose=True,
        )

        llm_input = {
            "problem": get_first_dict_by_key(chatlog, "problem")["msg"],
            "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
        }
        if streaming:
            # Streamを使用して出力を逐次処理
            input_text = "\n".join(
                [f"{key}: {value}" for key, value in llm_input.items()]
            )
            ans: str = "".join(
                [chunk.content for chunk in chain.llm.stream(input=input_text)]
            )
            return ans
        else:
            # 通常の方法で呼び出し
            ans: dict = chain.invoke(input=llm_input)
            return ans["text"]


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None
