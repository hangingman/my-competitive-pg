from langchain.memory import ConversationTokenBufferMemory
from langchain_core.language_models import BaseLanguageModel


class CustomMemory:
    def __init__(self, llm: BaseLanguageModel):
        super().__init__()
        self.memory = ConversationTokenBufferMemory(llm=llm, buffer_size=2000)

    def save_context(self, inputs, outputs):
        self.memory.save_context(inputs, outputs)

    def load_context(self):
        return self.memory.load_context()

    def clear(self):
        self.memory.clear()
