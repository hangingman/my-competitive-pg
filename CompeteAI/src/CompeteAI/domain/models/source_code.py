from typing import Dict, List

from pydantic.v1 import BaseModel, Field


class SourceCode(BaseModel):
    description: str = Field(description="ソースコードの説明")
    source_code: str = Field(description="ソースコード")


class SourceCodeWithResult(BaseModel):
    description: str = Field(description="ソースコードの説明")
    source_code: str = Field(description="ソースコード")
    result: str = Field(description="実行結果")
