from typing import Dict, List

from pydantic.v1 import BaseModel, Field


class AlgorithmCandidate(BaseModel):
    description: str = Field(description="アルゴリズムの詳細な説明")
    pseudo_code: str = Field(description="擬似コード")
    advantages: str = Field(description="利点と欠点")
    worst_case_complexity: str = Field(description="最悪計算量（Big-O表記）")
    execution_time_estimates: Dict[str, str] = Field(
        description="具体的なデータサイズ（10^5, 10^6, 10^9）に対する実行時間の推定"
    )


class AlgorithmCandidates(BaseModel):
    candidates: List[AlgorithmCandidate]
