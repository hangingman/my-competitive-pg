import math
import random

from CompeteAI.domain.models.algorithm_candidate import (AlgorithmCandidate,
                                                         AlgorithmCandidates)
from CompeteAI.domain.models.node import Node


class MCTS:
    def __init__(
        self, root_candidate: AlgorithmCandidate, candidates: AlgorithmCandidates
    ):
        self.root = Node(root_candidate)
        self.candidates = candidates

    def mcts(self, max_iterations: int):
        for _ in range(max_iterations):
            node = self.__selection(self.root)
            if node.failed:
                continue
            child = self.__expansion(node)
            result = self.__simulation(child)
            self.__backpropagation(child, result)
            if result:
                break  # 成功した場合、探索を終了する
        return self.root

    def __selection(self, node: Node) -> Node:
        while node.is_fully_expanded():
            node = max(node.children, key=self.__ucb1)
        return node

    def __expansion(self, node: Node) -> Node:
        if not node.is_fully_expanded():
            new_candidate = random.choice(self.candidates.candidates)
            new_node = Node(new_candidate, parent=node)
            node.children.append(new_node)
        return random.choice(node.children)

    def __simulation(self, node: Node) -> bool:
        return self.__simulate_algorithm(node.algorithm_candidate)

    def __backpropagation(self, node: Node, result: bool):
        while node:
            node.visits += 1
            if result:
                node.successes += 1
            else:
                node.failed = True
            node = node.parent

    def __ucb1(self, node: Node) -> float:
        C = 1.4
        if node.visits == 0:
            return float("inf")
        return node.successes / node.visits + C * math.sqrt(
            math.log(node.parent.visits) / node.visits
        )

    def __simulate_algorithm(self, candidate: AlgorithmCandidate) -> bool:
        # ここでアルゴリズムのテストを行い、成功ならTrueを返す
        # 仮に常に成功するシミュレーションとして実装
        return True
