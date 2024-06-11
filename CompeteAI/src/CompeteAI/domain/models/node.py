class Node:
    def __init__(self, algorithm_candidate, parent=None):
        self.algorithm_candidate = algorithm_candidate
        self.parent = parent
        self.children = []
        self.visits = 0
        self.successes = 0
        self.failed = False

    def is_fully_expanded(self):
        return len(self.children) > 0
