import os
from langchain_openai import ChatOpenAI, ChatPromptTemplate
from CompeteAI.domain.models.problem_statement import ProblemStatement
from CompeteAI.infra.memory.memory import CustomMemory


class ProblemSolvingAgent:
    def __init__(self, tool):
        self.tool = tool
        self.memory = CustomMemory()
        api_key = os.getenv("OPENAI_API_KEY")
        self.prompt = ChatPromptTemplate.from_messages([
            ('system', "dummy"),
            ('user', ""),
        ])
        self.llm = ChatOpenAI(api_key=api_key, model_name="gpt-4-turbo")

    def solve_problem(self, problem_statement: ProblemStatement) -> str:
        context = self.memory.load_context()
        messages = self.prompt.format_messages(system=context, user=problem_statement.text)
        solution = self.llm.invoke(messages)
        self.memory.save_context(problem_statement.text, solution)
        return solution
