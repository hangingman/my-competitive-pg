from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.domain.tools.algorithm_strategy_tool import \
    AlgorithmStrategyTool


class ProblemSolvingAgent:
    def __init__(self, tool):
        self.tool = tool

    def solve_problem(self, problem_statement: ProblemStatement) -> str:
        return self.tool.run(problem_statement.text)
