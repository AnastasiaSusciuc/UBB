def check_if_string_in_list(chr, lst):
    for x in lst:
        if chr in x:
            return True
    return False


class Parser:
    def __init__(self, grammar):
        self.grammar = grammar
        self.first_set = {i: set() for i in self.grammar.non_terms}
        self.follow_set = {i: set() for i in self.grammar.non_terms}
        self.build_first_set()
        self.build_follow_set()

    def print_set(self, set_to_print):
        for i in set_to_print:
            print(i, end=": ")
            for j in set_to_print[i]:
                print(j, end=" ")
            print('\n', end="")

    def innerLoop(self, initialSet, item, additionalSet):
        copySet = initialSet

        if item in self.grammar.non_terms:
            copySet = copySet.union(entry for entry in self.first_set[item] if entry != 'E')
            if 'E' in self.first_set[item]:  # for follow; if E is in FIRST(item) then
                # everything in FOLLOW(
                copySet = copySet.union(additionalSet)
        else:
            copySet = copySet.union({item})

        return copySet

    def build_first_set(self):

        # for prod in self.grammar.productions:
        #     for term in prod.rhs:
        #         term = term.split()
        #         if term[0] in self.grammar.terms:
        #             self.first_set[prod.lhs[0]].add(term[0])
        #         if term[0].strip == 'E':
        #             self.first_set[prod.lhs[0]].add('E')

        set_is_changed = True
        while set_is_changed is True:
            set_is_changed = False
            for prod in self.grammar.productions:
                for term in prod.rhs:
                    v = term.split()  # v = B C

                    copySet = self.first_set[prod.lhs[0]]
                    copySet = copySet.union(self.innerLoop(copySet, v[0], ['E']))

                    if len(self.first_set[prod.lhs[0]]) != len(copySet):
                        self.first_set[prod.lhs[0]] = copySet
                        set_is_changed = True

    def build_follow_set(self):
        for term in self.grammar.non_terms:
            self.follow_set[term].add("E")

        set_is_changed = True
        while set_is_changed is True:
            set_is_changed = False
            for prod in self.grammar.productions:
                for term in prod.rhs:
                    v = term.split()
                    for i in range(len(v)):
                        if v[i].strip() not in self.grammar.non_terms:  # if the literal in the rhs of
                            # the production is a non-terminal then we skip it
                            continue
                        copySet = self.follow_set[v[i]]

                        if i < len(v) - 1:  # if the non-terminal is not the last one in the rhs of
                            # the production
                            copySet = copySet.union(self.innerLoop(copySet, v[i + 1],
                                                                   self.follow_set[prod.lhs[0].strip()]))
                        else:
                            copySet = copySet.union(self.follow_set[prod.lhs[0].strip()])

                        if len(self.follow_set[v[i]]) != len(copySet):
                            self.follow_set[v[i]] = copySet
                            set_is_changed = True


