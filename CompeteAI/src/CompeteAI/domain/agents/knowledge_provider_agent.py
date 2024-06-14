import os

import langchain
from langchain.chains.llm import LLMChain
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         SystemMessagePromptTemplate)
from langchain_openai import ChatOpenAI

from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class KnowledgeProviderAgent:
    def __init__(self, handler: StreamHandler, tool=None):
        self.tool = tool
        self.llm = ChatOpenAI(
            api_key=os.getenv("OPENAI_API_KEY"),
            model_name="gpt-4-turbo",
            temperature=0.3,
            streaming=True,
            callbacks=[handler],
        )

        self.memory = CustomMemory(llm=self.llm)

    def solve(self, chatlog: []) -> str:
        langchain.verbose = True
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
        chain = LLMChain(
            prompt=ChatPromptTemplate.from_messages(
                [knowledge_prompt]
            ),
            #output_key="algorithm_candidates",
            llm=self.llm,
            verbose=True,
        )

        ans = chain.invoke(
            {
                "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
            }
        )
        return ans["text"]


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None
