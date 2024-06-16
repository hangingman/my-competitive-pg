from enum import Enum


class LLMType(Enum):
    OPENAI = "openai"
    GOOGLE = "google"

    def default_model_name(self):
        if self == LLMType.OPENAI:
            return "gpt-4-turbo"
        elif self == LLMType.GOOGLE:
            return "gemini-1.5-pro"
        else:
            raise ValueError(f"Unsupported LLM type: {self}")

    def light_model_name(self):
        if self == LLMType.OPENAI:
            return "gpt-3.5-turbo"
        elif self == LLMType.GOOGLE:
            return "gemini-1.5-flash"
        else:
            raise ValueError(f"Unsupported LLM type: {self}")
