class Node:
    def __init__(self, value, child, rs):
        self.value = value
        self.child = child
        self.right_sibling = rs

    def __str__(self):
        return "({}, {}, {})".format(self.value, self.child, self.right_sibling)


class Tree:
    def __init__(self, grammar):
        self.root = None
        self.grammar = grammar
        self.crt = 1
        self.ws = ""
        self.indexInTreeSequence = 1

    