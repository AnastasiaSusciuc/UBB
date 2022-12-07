from Grammar import Grammar
from Parser import Parser


class UI:

    def __init__(self, grammar, parser):
        self.grammar = grammar
        self.parser = parser
        # self.print_menu()
        self.run()

    def run(self):
        print("FIRST SET")
        self.parser.print_set(self.parser.first_set)
        print("FOLLOW SET")
        self.parser.print_set(self.parser.follow_set)

    def print_menu(self):
        print("What do you want to see?\na) set of non terminals\nb) set of terminals\nc) start symbol\nd) set of productions\ne) set of "
              "productions for a given non terminal\nf) cfg check\ng) first for\nx) exit\n")
        opt = input(">")
        while opt != 'x':
            if opt == 'a':
                print(self.grammar.non_terms)
            if opt == 'b':
                print(self.grammar.terms)
            if opt == 'c':
                print(self.grammar.start_symbol)
            if opt == 'd':
                for one in self.grammar.productions:
                    print(one)
            if opt == 'e':
                non_term = input("write your non term:")
                for one in self.grammar.productions:
                    if non_term in one.lhs:
                        print(one)
            if opt == 'f':
                if self.grammar.check_CFG():
                    print("Grammar is CFG")
                else:
                    print("Grammar is not CFG")
            if opt == 'g':
                # symbol = input("First set for:")
                print(self.parser.build_first_set())
            opt = input(">")


grammar = Grammar("g2.txt")
parser = Parser(grammar)
ui = UI(grammar, parser)
