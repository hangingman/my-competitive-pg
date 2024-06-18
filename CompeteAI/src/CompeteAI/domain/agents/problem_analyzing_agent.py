from langchain.chains.llm import LLMChain
from langchain_core.prompts.chat import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain.callbacks.tracers import ConsoleCallbackHandler

from CompeteAI.domain.factory.llm_factory import LLMFactory
from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class ProblemAnalyzingAgent:
    def __init__(self, llm: LLMType, handler: StreamHandler, tool=None):
        self.tool = tool
        self.llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.default_model_name(),
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def analyze_problem(
        self,
        problem_statement: ProblemStatement,
        streaming: bool = True,
    ) -> str:
        # context = self.memory.load_context()
        prompt = ChatPromptTemplate.from_messages(
            [
                SystemMessagePromptTemplate(
                    prompt=PromptTemplate(
                        template="""# 命令書:
あなたはアルゴリズム問題の専門家です。以下の制約条件と入力文をもとに複数の分析を出力してください。

* 問題文から、求められている最終的な解答内容を特定せよ
* 問題文に記載されている情報、データ、数値などをすべて列挙せよ
* 問題を解決する際に考慮すべき制約やルールを明確にせよ
* 入力文を要約し、問題の全体像を簡潔に説明せよ

# 制約条件:
* 回答は日本語で行うこと
* 解答が問題から自明な場合でも出力しないこと
* 時間制限が特にない場合、２秒以内での解答を制約条件とせよ
""",
                        input_variables=[],
                    )
                ),
                HumanMessagePromptTemplate(
                    prompt=PromptTemplate(
                        template="""# 入力文：\n{problem}""",
                        input_variables=["problem"],
                    )
                ),
            ]
        )

        llm_input = {
            "problem": problem_statement.text,
        }
        if streaming:
            # LCEL記法でprompt | model | output parserみたいに書く
            # ref: https://python.langchain.com/v0.1/docs/expression_language/streaming/
            parser = StrOutputParser()
            chain = prompt | self.llm | parser
            # streamを使用して出力を逐次処理, debug logを出すためにconfigを渡す必要がある
            # ref: https://qiita.com/isanakamishiro2/items/37ea6ac2049bf23e8405
            ans: str = "".join(
                [chunk for chunk in chain.stream(input=llm_input, config={'callbacks': [ConsoleCallbackHandler()]})]
            )
            return ans
        else:
            # 通常の方法で呼び出し
            chain = LLMChain(prompt=prompt, llm=self.llm, verbose=True)
            ans: dict = chain.invoke(input=llm_input)
            return ans["text"]
