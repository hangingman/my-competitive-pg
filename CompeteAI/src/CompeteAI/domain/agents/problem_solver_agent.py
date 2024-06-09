import os
from langchain_openai import ChatOpenAI
from langchain_core.prompts.chat import ChatPromptTemplate
import langchain
from langchain.chains.llm import LLMChain

from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.infra.memory.memory import CustomMemory


class ProblemSolverAgent:
    def __init__(self, tool=None):
        self.tool = tool
        api_key = os.getenv("OPENAI_API_KEY")
        self.llm = ChatOpenAI(
            api_key=api_key,
            model_name="gpt-4-turbo",
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def solve(self, chatlog: []) -> str:
        langchain.verbose = True
        #context = self.memory.load_context()
        prompt = ChatPromptTemplate.from_messages([
            ('system', """# 命令書:
あなたはアルゴリズム問題の専門家です。以下の制約条件と問題文をもとにアルゴリズムを検討し疑似コードを出力せよ。

# 制約条件:
* 疑似コードのプログラミング言語は指定がなければPythonで書いてください
"""),
            ('system', """{analysis}"""),
            ('user', """# 入力文：
{problem}"""),
        ])

        chain = LLMChain(
            prompt=prompt,
            llm=self.llm,
            verbose=True,
            # memory=memory,
        )

        psedo_code: dict = chain.invoke(input={
            'analysis': get_first_dict_by_key(chatlog, 'analysis')['msg'],
            'problem': get_first_dict_by_key(chatlog, 'problem')['msg'],
        })
        #self.memory.save_context(problem_statement.text, solution)
        return psedo_code['text']


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry['key'] == key:
            return entry
    return None
