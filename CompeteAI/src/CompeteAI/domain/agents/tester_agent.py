import contextlib
import io
import sys
import tempfile
from typing import Generator, Tuple

from langchain.chains.llm import LLMChain
from langchain.output_parsers import PydanticOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.prompts.chat import (ChatPromptTemplate,
                                         HumanMessagePromptTemplate,
                                         SystemMessagePromptTemplate)
from langchain_core.output_parsers import StrOutputParser
from langchain.callbacks.tracers import ConsoleCallbackHandler
from wandbox import cli as wandbox_cli

from CompeteAI.domain.factory.llm_factory import LLMFactory
from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.domain.models.source_code import SourceCode
from CompeteAI.domain.models.test_case import TestCases
from CompeteAI.infra.memory.memory import CustomMemory
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class TesterAgent:
    def __init__(self, llm: LLMType, handler: StreamHandler = None):
        self.llm = LLMFactory.create_llm(
            llm_type=llm,
            handler=handler,
            model_name=llm.light_model_name(),
            temperature=0.0,
        )
        self.memory = CustomMemory(llm=self.llm)

    def __wandbox_run(self, opt: list[str]) -> str:
        try:
            cli = wandbox_cli.CLI()
            eprint(opt)
            with capture_output() as (c_stdout, c_stderr):
                cli.execute_with_args(opt)
        except SystemExit as e:
            exit_code = e.code
            eprint(f"ExitException caught with code: {exit_code}")
            eprint(exit_code)
            return c_stdout.getvalue() + "\n" + c_stderr.getvalue()

    def gen_test_case(self, chatlog: [], streaming: bool = True) -> TestCases:
        # context = self.memory.load_context()
        parser = PydanticOutputParser(pydantic_object=TestCases)

        test_case_prompt = SystemMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 命令書:
        * あなたは最高のQAエンジニアです。入力文をもとにテストケースを生成せよ。
        * テストケースをJSONで出力すること
        * 入力文に明確なテストケースが存在しない場合空のJSONを返すこと

        {format_instructions}
        """,
                input_variables=[],
                partial_variables={
                    "format_instructions": parser.get_format_instructions()
                },
            )
        )
        problem_prompt = HumanMessagePromptTemplate(
            prompt=PromptTemplate(
                template="""# 入力文：\n{problem}""",
                input_variables=["problem"],
            )
        )

        prompt = ChatPromptTemplate.from_messages([test_case_prompt, problem_prompt])
        llm_input = {"problem": get_first_dict_by_key(chatlog, "problem")["msg"]}

        if streaming:
            # Streamを使用して出力を逐次処理
            chain = prompt | self.llm | StrOutputParser()
            ans: str = "".join(
                [chunk for chunk in chain.stream(input=llm_input, config={'callbacks': [ConsoleCallbackHandler()]})]
            )
            return parser.parse(ans)
        else:
            # 通常の方法で呼び出し
            chain = LLMChain(prompt=prompt, llm=self.llm, verbose=True)
            ans: dict = chain.invoke(input=llm_input)
            return parser.parse(ans["text"])

    def test(self, chatlog: [], test_cases: TestCases, code: SourceCode) -> list[str]:
        results: list[str] = []

        if len(test_cases.cases) == 0:
            # テストケースなしの場合
            with tempfile.NamedTemporaryFile(suffix=".rb") as temp_source:
                eprint(code.source_code)
                temp_source.write(bytes(code.source_code, "utf-8"))
                temp_source.flush()
                ret = self.__wandbox_run(opt=["-l=Ruby", "run", temp_source.name])
                results.append(ret)
            return results

        for _, case in enumerate(test_cases.cases):
            with tempfile.NamedTemporaryFile(suffix=".rb") as temp_source:
                eprint(code.source_code)
                temp_source.write(bytes(code.source_code, "utf-8"))
                temp_source.flush()
                ret = self.__wandbox_run(
                    opt=[
                        "-l=Ruby",
                        "--stdin",
                        f'"{case.input}"',
                        "run",
                        temp_source.name,
                    ]
                )
                results.append(ret)

        return results


def get_first_dict_by_key(chat_log, key):
    for entry in chat_log:
        if entry["key"] == key:
            return entry
    return None


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


@contextlib.contextmanager
def capture_output() -> Generator[Tuple[io.StringIO, io.StringIO], None, None]:
    """一時的に標準出力と標準エラー出力をキャプチャする関数"""
    stdout = io.StringIO()
    stderr = io.StringIO()
    with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
        yield stdout, stderr
