from Grammar import Grammar
from Parser import Parser
from Tree import Tree


class UI:

    def __init__(self, grammar, parser, seq):
        self.__grammar = grammar
        self.__parser = parser
        self.__seq = seq
        # self.print_menu()
        self.run()

    def run(self):
        print("FIRST SET")
        self.__parser.print_set(self.__parser.first_set)
        print("FOLLOW SET")
        self.__parser.print_set(self.__parser.follow_set)
        print("TABLE")
        for k in self.__parser.table.keys():
            print(k, '->', self.__parser.table[k])

        result = self.__parser.evaluate_seq(self.read_sequence(self.__seq))

        if result is None:
            print("Sequence is not accepted")
        else:
            print("Sequence is accepted")
            print(result)
            t = Tree(self.__grammar)
            t.build(result.strip().split(' '))
            t.print_table()

    @staticmethod
    def read_sequence(file):
        sequence = ""
        with open(file, 'r') as fin:
            for line in fin.readlines():
                sequence += line.strip() + " "
        return sequence.strip()

    def print_menu(self):
        print("What do you want to see?\na) set of non terminals\nb) set of terminals\nc) start symbol\nd) set of productions\ne) set of "
              "productions for a given non terminal\nf) cfg check\ng) first for\nx) exit\n")
        opt = input(">")
        while opt != 'x':
            if opt == 'a':
                print(self.__grammar.non_terms)
            if opt == 'b':
                print(self.__grammar.terms)
            if opt == 'c':
                print(self.__grammar.start_symbol)
            if opt == 'd':
                for one in self.__grammar.productions:
                    print(one)
            if opt == 'e':
                non_term = input("write your non term:")
                for one in self.__grammar.productions:
                    if non_term in one.lhs:
                        print(one)
            if opt == 'f':
                if self.__grammar.check_CFG():
                    print("Grammar is CFG")
                else:
                    print("Grammar is not CFG")
            if opt == 'g':
                # symbol = input("First set for:")
                print(self.__parser.build_first_set())
            opt = input(">")


# grammar = Grammar("gAnis.txt")
# parser = Parser(grammar)
# ui = UI(grammar, parser, "seqAnis.txt")

grammar = Grammar("input_programs/g3.txt")
parser = Parser(grammar)
ui = UI(grammar, parser, "input_sequences/seq.txt")
