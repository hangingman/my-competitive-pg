import streamlit as st

from CompeteAI.domain.agents.problem_solving_agent import ProblemSolvingAgent
from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.domain.tools.algorithm_strategy_tool import \
    AlgorithmStrategyTool


def main():
    st.title("CompeteAI: Competitive Programming with LLM")
    st.write(
        "Welcome to CompeteAI. Start solving problems and get real-time feedback from the LLM!"
    )

    input_type = st.radio("入力方法を選択してください", ("URL入力", "テキスト直接入力"))

    if input_type == "URL入力":
        url = st.text_input("ここに問題のURLを入力")
        if st.button("問題の分析"):
            problem_statement = ProblemStatement("")
            problem_statement.set_url(url)
            agent = ProblemSolvingAgent(AlgorithmStrategyTool())
            solution = agent.solve_problem(problem_statement)
            st.write("分析結果:", solution)
    else:
        text = st.text_area("ここに問題のテキストを入力", value="""素数を小さい方から6つ並べると 2, 3, 5, 7, 11, 13 であり, 6番目の素数は 13 である.
10001 番目の素数を求めよ.""")
        if st.button("問題を分析"):
            problem_statement = ProblemStatement(text)
            agent = ProblemSolvingAgent(AlgorithmStrategyTool())
            solution = agent.solve_problem(problem_statement)
            st.write("分析結果:", solution)


if __name__ == "__main__":
    main()
