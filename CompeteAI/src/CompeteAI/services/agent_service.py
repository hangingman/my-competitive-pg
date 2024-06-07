from CompeteAI.domain.agents.problem_solving_agent import ProblemSolvingAgent
from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.domain.tools.algorithm_strategy_tool import \
    AlgorithmStrategyTool


class AgentService:
    def __init__(self):
        tool = AlgorithmStrategyTool()
        self.agent = ProblemSolvingAgent(tool=tool)

    def solve_problem(self, problem_statement_text: str) -> str:
        problem_statement = ProblemStatement(text=problem_statement_text)
        return self.agent.solve_problem(problem_statement)
