from langchain.chains.llm import LLMChain
from langchain_core.prompts.chat import ChatPromptTemplate

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
                (
                    "system",
                    """# 命令書:
あなたはアルゴリズム問題の専門家です。以下の制約条件と入力文をもとに複数の分析を出力してください。

* 問題文から、求められている最終的な解答内容を特定せよ
* 問題文に記載されている情報、データ、数値などをすべて列挙せよ
* 問題を解決する際に考慮すべき制約やルールを明確にせよ
* 入力文を要約し、問題の全体像を簡潔に説明せよ

# 制約条件:
* 解答が問題から自明な場合でも出力しないこと
* 時間制限が特にない場合、２秒以内での解答を制約条件とせよ
""",
                ),
                (
                    "user",
                    f"""# 入力文：
{problem_statement.text}""",
                ),
            ]
        )

        chain = LLMChain(
            prompt=prompt,
            llm=self.llm,
            verbose=True,
            # memory=memory,
        )

        if streaming:
            # Streamを使用して出力を逐次処理
            ans: str = "".join([chunk.content for chunk in chain.llm.stream("")])
            return ans
        else:
            # 通常の方法で呼び出し
            ans: dict = chain.invoke(input={})
            return ans["text"]
