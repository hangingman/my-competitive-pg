from CompeteAI.domain.models.problem_statement import ProblemStatement


class AlgorithmStrategyTool:
    def run(self, problem_statement: str) -> str:
        strategy = self.analyze_problem(problem_statement)
        return strategy

    def analyze_problem(self, problem_statement: str) -> str:
        if "時間制限" in problem_statement:
            return "時間制限がある場合、効率的なアルゴリズム（例：二分探索、動的計画法、貪欲法など）を選択してください。"
        else:
            return "詳細な問題文が必要です。"
