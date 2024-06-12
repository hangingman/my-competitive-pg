import os
import sys
import tempfile

import langchain
from langchain.chains.llm import LLMChain
from langchain.output_parsers import PydanticOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         SystemMessagePromptTemplate)
from langchain_openai import ChatOpenAI
from wandbox import cli as wandbox_cli

from CompeteAI.domain.models.source_code import SourceCode
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class CoderAgent:
    def __init__(self, handler: StreamHandler):
        self.llm = ChatOpenAI(
            api_key=os.getenv("OPENAI_API_KEY"),
            model_name="gpt-4-turbo",
            temperature=0.0,
            streaming=False,
            # callbacks=[handler],
        )
        self.memory = CustomMemory(llm=self.llm)

    def wandbox_run(self, opt: list[str]):
        cli = wandbox_cli.CLI()
        eprint(opt)
        cli.execute_with_args(opt)

    def solve(self, chatlog: []) -> SourceCode:
        langchain.verbose = True
        # context = self.memory.load_context()
        parser = PydanticOutputParser(pydantic_object=SourceCode)

        # ソースコードを生成しJSONにフォーマットするchain
        source_code_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
        * あなたはアルゴリズムと数学に長けた最高のプログラマーです。入力文の擬似コードをもとにRubyコードを出力せよ。
        * ソースコードの説明とソースコード自体をJSONで出力すること
        * 解答内容に沿った出力を出すこと

        {format_instructions}
        # 制約条件:
        {analysis}
        # 入力文:
        {pseudo_code}
        """,
                input_variables=["analysis", "pseudo_code"],
                partial_variables={
                    "format_instructions": parser.get_format_instructions()
                },
            )
        )

        chain = LLMChain(
            prompt=ChatPromptTemplate.from_messages([source_code_prompt]),
            llm=self.llm,
            verbose=True,
            # memory=memory,
        )

        ans: dict = chain.invoke(
            input={
                "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
                "pseudo_code": get_first_dict_by_key(chatlog, "pseudo_code")["msg"],
            }
        )
        # self.memory.save_context(problem_statement.text, solution)
        code: SourceCode = parser.parse(ans["text"])

        with tempfile.NamedTemporaryFile(suffix=".rb") as temp_source:
            eprint(code.source_code)
            temp_source.write(bytes(code.source_code, "utf-8"))
            temp_source.flush()
            self.wandbox_run(opt=["-l=Ruby", "run", temp_source.name])

        return code


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
