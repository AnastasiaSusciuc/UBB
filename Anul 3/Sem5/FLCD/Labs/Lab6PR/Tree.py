class Node:
    def __init__(self, value, father, rs):
        self.value = value
        self.father = father
        self.right_sibling = rs

    def __str__(self):
        return "({}, {}, {})".format(self.value, self.father, self.right_sibling)


class Tree:
    def __init__(self, grammar):
        self.root = None
        self.grammar = grammar
        self.crt = 1
        self.ws = ""
        self.indexInTreeSequence = 1

    def build(self, ws):
        print("WORKING STACK")
        print(ws)
        print(len(ws))
        self.ws = ws
        production = self.grammar.get_production_for_index(int(self.ws[0]))
        nonterminal, rhs = production.lhs[0], production.rhs[0]

        self.root = Node(nonterminal, None, None)
        self.root.father = self._build_recursive(rhs.split())
        return self.root

    def _build_recursive(self, currentTransition):
        print("CURRENT TRANSITION: " + str(currentTransition))
        print("INDEX " + str(self.indexInTreeSequence))
        if self.indexInTreeSequence == len(self.ws) and currentTransition == ['E']:
            pass
        elif currentTransition == [] or self.indexInTreeSequence >= len(self.ws)+1:
            return None

        currentSymbol = currentTransition[0]
        if currentSymbol in self.grammar.terms:
            node = Node(currentSymbol, None, None)
            print("current value: " + node.value)
            print("finished terminal branch")
            print("CURRENT TRANSITION: " + str(currentTransition) + " ___ " + str(currentTransition[1:]))
            node.right_sibling = self._build_recursive(currentTransition[1:])
            return node
        elif currentSymbol in self.grammar.non_terms:
            transitionNumber = self.ws[self.indexInTreeSequence]
            production = self.grammar.get_production_for_index(int(transitionNumber))
            node = Node(currentSymbol, None, None)
            print("current value: " + node.value)
            print("finished nonterminal branch")
            print("CURRENT TRANSITION: " + str(currentTransition) + " ___ " + str(currentTransition[1:]))
            self.indexInTreeSequence += 1
            rhs = production.rhs[0].split()
            node.father = self._build_recursive(rhs)
            node.right_sibling = self._build_recursive(currentTransition[1:])
            return node
        else:
            print('E branch')
            return Node("E", None, None)

    def print_table(self):
        self._dfs(self.root)

    def _dfs(self, node, father_crt=None, left_sibling_crt=None):
        if node is None:
            return []

        f = open("output_g1.txt", "a")
        f.write("Index: {} | Value: {} | Father: {} | Left_Sibling: {}\n".format(self.crt, node.value, father_crt,
                                                                                 left_sibling_crt))
        print("Index: {} | Value: {} | Father: {} | Left_Sibling: {}".format(self.crt, node.value, father_crt,
                                                                             left_sibling_crt))

        crt = self.crt
        self.crt += 1

        if left_sibling_crt is not None:
            return [[node.father, crt, None]] + self._dfs(node.right_sibling, father_crt, crt)
        else:
            children = [[node.father, crt, None]] + self._dfs(node.right_sibling, father_crt, crt)
            for child in children:
                self._dfs(*child)

    def __str__(self):
        string = ""
        node = self.root
        while node is not None:
            string += str(node)
            node = node.right_sibling
        return string
