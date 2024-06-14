from typing import Dict, List

from pydantic.v1 import BaseModel, Field


class SourceCode(BaseModel):
    description: str = Field(description="ソースコードの説明")
    source_code: str = Field(description="ソースコード")
