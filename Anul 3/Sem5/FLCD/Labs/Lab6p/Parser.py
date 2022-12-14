def check_if_string_in_list(chr, lst):
    for x in lst:
        if chr in x:
            return True
    return False


class Parser:
    def __init__(self, grammar):
        self.grammar = grammar
        self.first_set = {i: set() for i in self.grammar.non_terms + self.grammar.terms}
        self.follow_set = {i: set() for i in self.grammar.non_terms}
        self.table = {}
        self.build_first_set()
        self.build_follow_set()
        self.build_table()

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

    def add_first_set(self, initialSet, items):

        copySet = initialSet
        for i in range(len(items)):
            if items[i] in self.grammar.non_terms:
                copySet = copySet.union(entry for entry in self.first_set[items[i]] if entry != 'E')
                if 'E' in self.first_set[items[i]]:
                    if i < len(items) - 1:
                        continue
                    copySet = copySet.union('E')
                    break
                else:
                    break
            else:
                copySet = copySet.union({items[i]})
                break

        return copySet

    def build_first_set(self):

        # for prod in self.grammar.productions:
        #     for term in prod.rhs:
        #         term = term.split()
        #         if term[0] in self.grammar.terms:
        #             self.first_set[prod.lhs[0]].add(term[0])
        #         if term[0].strip == 'E':
        #             self.first_set[prod.lhs[0]].add('E')

        for term in self.grammar.terms:
            self.first_set[term].add(term)

        set_is_changed = True
        while set_is_changed is True:
            set_is_changed = False
            for prod in self.grammar.productions:
                for term in prod.rhs:
                    v = term.split()  # v = ( s )

                    workingSet = self.add_first_set(self.first_set[prod.lhs[0]], v)

                    if len(self.first_set[prod.lhs[0]]) != len(workingSet):
                        self.first_set[prod.lhs[0]] = workingSet
                        set_is_changed = True

    def build_follow_set(self):
        self.follow_set[self.grammar.start_symbol].add("$")
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

                        if i < len(v) - 1:  # if the non-terminal is not the last one in the rhs of the production

                            if 'E' in self.first_set[v[i+1]]:  # case 3 and contains E
                                copySet = copySet.union(self.innerLoop(copySet, v[i + 1],
                                                                       self.follow_set[prod.lhs[0].strip()]))
                            else:  # case 2
                                copySet = copySet.union(self.innerLoop(copySet, v[i + 1],
                                                                       self.first_set[v[i+1].strip()]))
                        else:  # case 3
                            copySet = copySet.union(self.follow_set[prod.lhs[0].strip()])

                        if len(self.follow_set[v[i]]) != len(copySet):
                            self.follow_set[v[i]] = copySet
                            set_is_changed = True

    def build_table(self):
        nonterminals = self.grammar.non_terms
        terminals = self.grammar.terms
        index = 0
        for prod in self.grammar.productions:
            index = index + 1
            # value = (rhs, count)
            v = prod.rhs
            rowSymbol = prod.lhs[0].strip()  # A
            rule = v[0].split()  # alpha

            for columnSymbol in terminals + ['E']:  # coloana/ a
                pair = (rowSymbol, columnSymbol)  # M(A, a)
                print("PAIR")
                print(pair)
                print(rule)
                # rule 1 - 1
                if rule[0] == columnSymbol and columnSymbol != 'E':
                    print("primul iff _-- AAaaaaaaaaaa")
                    print(pair)
                    self.table[pair] = (v, index)
                elif rule[0] in nonterminals and columnSymbol in self.first_set[rule[0]]:
                    if pair not in self.table.keys():
                        print("al doilea iff _-- bbbbbbbbbbbbbb")
                        print(pair)
                        self.table[pair] = (v, index)
                    else:
                        print(pair)
                        print("Grammar is not LL(1).")
                        assert False
                else:
                    # rule 1 - 2
                    if rule[0] == 'E':
                        for b in self.follow_set[rowSymbol]:
                            if b == 'E':
                                b = '$'
                            self.table[(rowSymbol, b)] = (v, index)
                    else:
                        # rule 1 part 2
                        firsts = set()
                        for symbol in self.grammar.return_prod_lhs_non_terminal(rowSymbol):
                            if symbol in nonterminals:
                                firsts = firsts.union(self.first_set[symbol])
                        if 'E' in firsts:
                            for b in self.follow_set[rowSymbol]:
                                if b == 'E':
                                    b = '$'
                                if (rowSymbol, b) not in self.table.keys():
                                    self.table[(rowSymbol, b)] = v


                    # print("PAIRRRRR")
                    # print(pair)
                    #
                    # if pair in self.table.keys():
                    #     print("VALUE")
                    #     print(self.table[pair])

        # rule 2
        for t in terminals:
            self.table[(t, t)] = ('pop', -1)

        # rule 3
        self.table[('$', '$')] = ('acc', -1)

    # def build_follow_set(self):
    #
    #     # for term in self.grammar.non_terms:
    #     self.follow_set[self.grammar.start_symbol].add("E")
    #
    #     set_is_changed = True
    #     while set_is_changed is True:
    #         set_is_changed = False
    #         for prod in self.grammar.productions:
    #             for term in prod.rhs:
    #                 v = term.split()
    #                 for i in range(len(v)):
    #                     if v[i].strip() not in self.grammar.non_terms:  # if the literal in the rhs of
    #                         # the production is a non-terminal then we skip it
    #                         continue
    #                     copySet = self.follow_set[v[i]]
    #
    #                     if i < len(v) - 1:  # if the non-terminal is not the last one in the rhs of
    #                         # the production
    #                         copySet = copySet.union(self.innerLoop(copySet, v[i + 1],
    #                                                                self.follow_set[prod.lhs[0].strip()]))
    #                     else:
    #                         copySet = copySet.union(self.follow_set[prod.lhs[0].strip()])
    #
    #                     if len(self.follow_set[v[i]]) != len(copySet):
    #                         self.follow_set[v[i]] = copySet
    #                         set_is_changed = True
