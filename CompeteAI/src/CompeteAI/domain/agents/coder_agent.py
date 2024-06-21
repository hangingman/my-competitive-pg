import sys

from langchain.callbacks.tracers import ConsoleCallbackHandler
from langchain.chains.llm import LLMChain
from langchain.output_parsers import PydanticOutputParser
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         HumanMessagePromptTemplate,
                                         SystemMessagePromptTemplate)
from wandbox import cli as wandbox_cli

from CompeteAI.domain.factory.llm_factory import LLMFactory
from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.domain.models.source_code import SourceCode
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class CoderAgent:
    def __init__(self, llm: LLMType, handler: StreamHandler = None):
        self.llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.default_model_name(),
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def wandbox_run(self, opt: list[str]):
        try:
            cli = wandbox_cli.CLI()
            eprint(opt)
            cli.execute_with_args(opt)
        except SystemExit as e:
            exit_code = e.code
            eprint(f"ExitException caught with code: {exit_code}")
            eprint(exit_code)

    def solve(self, chatlog: [], streaming: bool = True) -> SourceCode:
        # context = self.memory.load_context()
        parser = PydanticOutputParser(pydantic_object=SourceCode)

        # ソースコードを生成しJSONにフォーマットするchain
        source_code_prompt_template = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
        * あなたはアルゴリズムと数学に長けた最高のプログラマーです。入力文の擬似コードをもとにRubyコードを出力せよ。
        * ソースコードの説明とソースコード自体をJSONで出力すること
        * ソースコードの実装上、解答は必ず標準出力に出すこと
        * インプットは標準入力(STDIN)に渡されることを想定せよ

        {format_instructions}
        """,
                input_variables=[],
                partial_variables={
                    "format_instructions": parser.get_format_instructions()
                },
            )
        )
        analysis_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 制約条件：\n{analysis}""",
                input_variables=["analysis"],
            )
        )
        pseudo_code_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 入力文：\n{pseudo_code}""",
                input_variables=["pseudo_code"],
            )
        )

        prompt = ChatPromptTemplate.from_messages(
            [source_code_prompt_template, analysis_prompt, pseudo_code_prompt]
        )
        llm_input = {
            "analysis": get_first_dict_by_key(chatlog, "analysis")["msg"],
            "pseudo_code": get_first_dict_by_key(chatlog, "pseudo_code")["msg"],
        }

        if streaming:
            # Streamを使用して出力を逐次処理
            chain = prompt | self.llm | StrOutputParser()
            ans: str = "".join(
                [
                    chunk
                    for chunk in chain.stream(
                        input=llm_input,
                        config={"callbacks": [ConsoleCallbackHandler()]},
                    )
                ]
            )
            return parser.parse(ans)
        else:
            # 通常の方法で呼び出し
            chain = LLMChain(prompt=prompt, llm=self.llm, verbose=True)
            ans: dict = chain.invoke(input=llm_input)
            return parser.parse(ans["text"])


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
