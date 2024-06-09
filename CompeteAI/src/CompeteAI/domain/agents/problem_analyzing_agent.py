import os

import langchain
from langchain.chains.llm import LLMChain
from langchain_core.prompts.chat import ChatPromptTemplate
from langchain_openai import ChatOpenAI

from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.infra.memory.memory import CustomMemory


class ProblemAnalyzingAgent:
    def __init__(self, tool=None):
        self.tool = tool
        api_key = os.getenv("OPENAI_API_KEY")
        self.llm = ChatOpenAI(
            api_key=api_key,
            model_name="gpt-4-turbo",
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def analyze_problem(self, problem_statement: ProblemStatement) -> str:
        langchain.verbose = True
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

        solution: dict = chain.invoke(input={})
        # self.memory.save_context(problem_statement.text, solution)
        return solution["text"]
