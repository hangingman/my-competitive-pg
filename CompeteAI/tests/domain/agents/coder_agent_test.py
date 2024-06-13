import tempfile

import pytest
from wandbox import cli as wandbox_cli

from CompeteAI.domain.agents.coder_agent import CoderAgent


@pytest.mark.parametrize(
    "input_opt, expected_opt",
    [
        (["-l=Ruby", "run"], ["-l=Ruby", "run"]),
        (["-l=Python", "run"], ["-l=Python", "run"]),
        (["-l=C++", "run"], ["-l=C++", "run"]),
    ],
)
def test_wandbox_run_mock(input_opt, expected_opt, mocker):
    coder = CoderAgent()
    mocker.patch(
        "CompeteAI.domain.agents.coder_agent.wandbox_cli.CLI.execute_with_args"
    )
    with tempfile.NamedTemporaryFile(suffix=".txt") as temp_source:
        temp_source.write(b"print('Hello, World!')")
        temp_source.flush()

        input_opt.append(temp_source.name)
        coder.wandbox_run(opt=input_opt)

        expected_opt.append(temp_source.name)
        wandbox_cli.CLI.execute_with_args.assert_called_once_with(expected_opt)


def test_wandbox_run():
    input_opt = ["-l=Ruby", "run", "--dryrun"]
    coder = CoderAgent()
    with tempfile.NamedTemporaryFile(suffix=".txt") as temp_source:
        temp_source.write(b"print('Hello, World!')")
        temp_source.flush()

        input_opt.append(temp_source.name)
        try:
            coder.wandbox_run(opt=input_opt)
        except SystemExit:  # SystemExitしないことをテスト
            pytest.fail("SystemExit exception occurred")
