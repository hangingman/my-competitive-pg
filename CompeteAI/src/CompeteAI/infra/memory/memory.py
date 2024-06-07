from langchain.memory import Memory


class CustomMemory(Memory):
    def __init__(self):
        super().__init__()
