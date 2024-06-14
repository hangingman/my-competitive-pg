from typing import Dict, List

from pydantic.v1 import BaseModel, Field


class TestCase(BaseModel):
    input: str = Field(description="入力文字列")
    answer: str = Field(description="想定解答")


class TestCases(BaseModel):
    cases: List[TestCase]
