import os
from typing import Union

import langchain
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_openai import ChatOpenAI

from CompeteAI.domain.models.llm_type import LLMType
from CompeteAI.interface_adapter.stream_handler import StreamHandler


class LLMFactory:
    default_openai_model_name = ""

    @staticmethod
    def create_llm(
        llm_type: LLMType,
        handler: StreamHandler,
        model_name: str,
        temperature: float = 0.0,
    ) -> Union[ChatOpenAI, ChatGoogleGenerativeAI]:
        langchain.verbose = True

        if llm_type == LLMType.OPENAI:
            return ChatOpenAI(
                api_key=os.getenv("OPENAI_API_KEY"),
                model_name=model_name,
                temperature=temperature,
                callbacks=[handler],
            )
        elif llm_type == LLMType.GOOGLE:
            return ChatGoogleGenerativeAI(
                google_api_key=os.getenv("GOOGLE_API_KEY"),
                model=model_name,
                temperature=temperature,
                callbacks=[handler],
            )
        else:
            raise ValueError(f"Unsupported LLM type: {llm_type}")
