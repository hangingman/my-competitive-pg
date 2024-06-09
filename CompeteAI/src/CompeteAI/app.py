import streamlit as st

from CompeteAI.domain.agents.problem_analyzing_agent import ProblemAnalyzingAgent
from CompeteAI.domain.agents.problem_solver_agent import ProblemSolverAgent
from CompeteAI.domain.models.problem_statement import ProblemStatement


def main():
    st.title("CompeteAI: Competitive Programming with LLM")
    st.write(
        "CompeteAI へようこそ。問題解決を開始し、LLM からリアルタイムのフィードバックを受け取りましょう。"
    )

    example1 = st.expander('問題文のサンプル1')
    example1.write("""素数を小さい方から6つ並べると 2, 3, 5, 7, 11, 13 であり, 6番目の素数は 13 である.
10001 番目の素数を求めよ.""")

    problem = st.chat_input("ここにURLか問題文を直接入力")

    # チャットログを保存したセッション情報を初期化
    if "chat_log" not in st.session_state:
        st.session_state.chat_log = []

    if problem:
        # 過去のチャットログを表示
        for chat in st.session_state.chat_log:
            with st.chat_message(chat["name"]):
                st.write(chat["msg"])

        with st.chat_message('user'):
            st.write(problem)
            st.session_state.chat_log.append({"name": 'user', 'key': 'problem', "msg": problem})

        # 問題を分析
        with st.chat_message('assistant'):
            problem_statement = ProblemStatement(problem)
            agent = ProblemAnalyzingAgent()
            analysis = agent.analyze_problem(problem_statement)
            st.header('分析結果:')
            st.write(analysis)
            st.session_state.chat_log.append({"name": 'assistant', 'key': 'analysis', "msg": analysis, 'header': '分析結果'})

        with st.chat_message('assistant'):
            agent = ProblemSolverAgent()
            pseudo_code = agent.solve(st.session_state.chat_log)
            st.header('疑似コード:')
            st.write(pseudo_code)
            st.session_state.chat_log.append({"name": 'assistant', 'key': 'pseudo_code', "msg": pseudo_code, 'header': '疑似コード'})


if __name__ == "__main__":
    main()
