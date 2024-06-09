from langchain.memory import ConversationTokenBufferMemory


class CustomMemory:
    def __init__(self):
        super().__init__()
        self.memory = ConversationTokenBufferMemory(buffer_size=2000)

    def save_context(self, inputs, outputs):
        self.memory.save_context(inputs, outputs)

    def load_context(self):
        return self.memory.load_context()

    def clear(self):
        self.memory.clear()
