import os

import langchain
from langchain.chains.llm import LLMChain
from langchain_core.prompts.chat import ChatPromptTemplate
from langchain_openai import ChatOpenAI

from CompeteAI.infra.memory.memory import CustomMemory


class ProblemSolverAgent:
    def __init__(self, tool=None):
        self.tool = tool
        api_key = os.getenv("OPENAI_API_KEY")
        self.llm = ChatOpenAI(
            api_key=api_key,
            model_name="gpt-4-turbo",
            temperature=0.8,
        )
        self.memory = CustomMemory(llm=self.llm)

    def solve(self, chatlog: []) -> str:
        langchain.verbose = True
        # context = self.memory.load_context()
        prompt = ChatPromptTemplate.from_messages(
            [
                (
                    "system",
                    """# 命令書:
あなたはアルゴリズムと数学に長けたアルゴリズム専門家です。
以下の制約条件と問題文をもとに少なくとも3つの実行可能なアルゴリズムを提案してください
それぞれのアルゴリズムについて、以下の情報を提供してください。

1. アルゴリズムの詳細な説明
2. 利点と欠点
3. 最悪計算量（Big-O表記）
4. 具体的なデータサイズ（10^3, 10^6, 10^9）に対する実行時間の推定

# 制約条件:
* コードの効率性を最優先し、できるだけ計算量を抑えた解法を提出してください
* 提案されたアルゴリズムは、競技プログラミングコンテストで実行可能であることが求められます, 実行時間の推定は現実的である必要があります
* 疑似コードは自然言語で記載すること
""",
                ),
                ("system", """{analysis}"""),
                (
                    "user",
                    """# 入力文：
{problem}""",
                ),
            ]
        )

        chain = LLMChain(
            prompt=prompt,
            llm=self.llm,
            verbose=True,
            # memory=memory,
        )

        psedo_code: dict = chain.invoke(
            input={
                "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
                "problem": get_first_dict_by_key(chatlog, "problem")["msg"],
            }
        )
        # self.memory.save_context(problem_statement.text, solution)
        return psedo_code["text"]


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None
