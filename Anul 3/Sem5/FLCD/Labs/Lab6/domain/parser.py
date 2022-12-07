class Parser:

    def __init__(self, grammar):
        self.grammar = grammar
        self.firstSet = {i: set() for i in self.grammar.get_non_terms()}
        self.followSet = {i: set() for i in self.grammar.get_non_terms()}
        self.table = {}
        self.generateFirst()
        self.generateFollow()
        self.generateTable()

    def innerLoop(self, initialSet, items, additionalSet):
        copySet = initialSet
        for i in range(len(items)):
            if self.grammar.isNonTerminal(items[i]):
                copySet = copySet.union(entry for entry in self.firstSet[items[i]] if entry != 'E')
                if 'E' in self.firstSet[items[i]]:
                    if i < len(items) - 1:
                        continue
                    copySet = copySet.union(additionalSet)
                    break
                else:
                    break
            else:
                copySet = copySet.union({items[i]})
                break

        return copySet

    def generateFirst(self):
        isSetChanged = False
        grammar_productions = self.grammar.get_productions()
        for value in grammar_productions:
            for v in value.rhs:
                v = self.grammar.split_rhs(v)
                copySet = self.firstSet[value.lhs[0]]
                copySet = copySet.union(self.innerLoop(copySet, v, ['E']))

                if len(self.firstSet[value.lhs[0]]) != len(copySet):
                    self.firstSet[value.lhs[0]] = copySet
                    isSetChanged = True

        grammar_productions = self.grammar.get_productions()
        while isSetChanged:
            isSetChanged = False
            for value in grammar_productions:
                for v in value.rhs:
                    v = self.grammar.split_rhs(v)
                    copySet = self.firstSet[value.lhs[0]]
                    copySet = copySet.union(self.innerLoop(copySet, v, ['E']))

                    if len(self.firstSet[value.lhs[0]]) != len(copySet):
                        self.firstSet[value.lhs[0]] = copySet
                        isSetChanged = True

    def generateFollow(self):
        pass

    def generateTable(self):
        pass
