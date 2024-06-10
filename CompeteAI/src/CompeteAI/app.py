import streamlit as st

from CompeteAI.domain.agents.coder_agent import CoderAgent
from CompeteAI.domain.agents.problem_analyzing_agent import \
    ProblemAnalyzingAgent
from CompeteAI.domain.agents.problem_solver_agent import ProblemSolverAgent
from CompeteAI.domain.models.algorithm_candidate import AlgorithmCandidates
from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.domain.models.source_code import SourceCode


def main():
    st.title("CompeteAI: Competitive Programming with LLM")
    st.write(
        "CompeteAI へようこそ。問題解決を開始し、LLM からリアルタイムのフィードバックを受け取りましょう。"
    )

    example1 = st.expander("問題文のサンプル1")
    example1.write(
        """素数を小さい方から6つ並べると 2, 3, 5, 7, 11, 13 であり, 6番目の素数は 13 である.
10001 番目の素数を求めよ."""
    )

    example2 = st.expander("問題文のサンプル2: #32 Pandigital products - Project Euler")
    example2.write(
        """すべての桁に 1 から n が一度だけ使われている数をn桁の数がパンデジタル (pandigital) であるということにしよう: 例えば5桁の数 15234 は1から5のパンデジタルである.
    7254 は面白い性質を持っている. 39 × 186 = 7254 と書け, 掛けられる数, 掛ける数, 積が1から9のパンデジタルとなる.
    掛けられる数, 掛ける数, 積が1から9のパンデジタルとなるような積の総和を求めよ.
    ヒント: いくつかの積は, 1通り以上の掛けられる数,掛ける数,積の組み合わせを持つが, 1回だけ数え上げよ."""
    )

    problem = st.chat_input("ここにURLか問題文を直接入力")

    # チャットログを保存したセッション情報を初期化
    if "chat_log" not in st.session_state:
        st.session_state.chat_log = []

    if problem:
        # 過去のチャットログを表示
        for chat in st.session_state.chat_log:
            with st.chat_message(chat["name"]):
                st.write(chat["msg"])

        with st.chat_message("user"):
            st.write(problem)
            st.session_state.chat_log.append(
                {"name": "user", "key": "problem", "msg": problem}
            )

        with st.chat_message("assistant"):
            problem_statement = ProblemStatement(problem)
            agent = ProblemAnalyzingAgent()
            analysis = agent.analyze_problem(problem_statement)
            st.header("分析結果:")
            st.write(analysis)
            st.session_state.chat_log.append(
                {
                    "name": "assistant",
                    "key": "analysis",
                    "msg": analysis,
                    "header": "分析結果",
                }
            )

        with st.chat_message("assistant"):
            # TODO: ここから木構造的に分岐する, ref: TCMS
            agent: ProblemSolverAgent = ProblemSolverAgent()
            candidates: AlgorithmCandidates = agent.solve(st.session_state.chat_log)

            for candidate in candidates:
                st.header("擬似コード:")
                st.write(candidate)
                st.session_state.chat_log.append(
                    {
                        "name": "assistant",
                        "key": "pseudo_code",
                        "msg": candidates,
                        "header": "擬似コード",
                    }
                )

                coder: CoderAgent = CoderAgent()
                code: SourceCode = coder.solve(st.session_state.chat_log)
                st.header("実コード:")
                st.code(code.source_code, language="ruby", line_numbers=False)
                st.session_state.chat_log.append(
                    {
                        "name": "assistant",
                        "key": "code",
                        "msg": code,
                        "header": "コード",
                    }
                )


if __name__ == "__main__":
    main()
