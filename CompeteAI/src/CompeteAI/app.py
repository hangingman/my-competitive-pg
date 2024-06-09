import streamlit as st

from CompeteAI.domain.agents.problem_analyzing_agent import ProblemAnalyzingAgent
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

    if problem:
        with st.chat_message('user'):
            st.write(problem)

        # 問題を分析
        with st.chat_message('assistant'):
            problem_statement = ProblemStatement(problem)
            agent = ProblemAnalyzingAgent()
            analysis = agent.analyze_problem(problem_statement)
            st.write("分析結果: \n" + analysis)


if __name__ == "__main__":
    main()
