from Lab4.Production import Production


class Grammar:
    def __init__(self):
        self.__non_terms = []
        self.__terms = []
        self.__productions = []
        self.__start_symbol = None
        self.file_path = "/Users/anastasiasusciuc/Desktop/UBB/Anul 3/Sem5/FLCD/Labs/Lab4/g1.txt"
        self.read_grammar()

    def get_non_terms(self):
        return self.__non_terms

    def get_productions(self):
        return self.__productions

    def split_rhs(self, prod):
        return prod.split(" ")

    def isNonTerminal(self, value):
        return value in self.__non_terms

    def read_grammar(self):
        lineCounter = 0
        with open(self.file_path) as reader:
            for line in reader:
                line = line.replace('\n', '')
                if lineCounter == 0:
                    self.__read_non_terms(line)
                elif lineCounter == 1:
                    self.__read_terms(line)
                elif lineCounter == 2:
                    self.__read_start_sym(line)
                else:
                    self.__read_productions(line)

                lineCounter = lineCounter + 1

    def __read_non_terms(self, line):
        self.__non_terms = line.split()

    def __read_terms(self, line):
        self.__terms = line.split()

    def __read_start_sym(self, line):
        self.__start_symbol = line.strip()

    def __read_productions(self, line):
        line = line.split("->")
        left = line[0].split()
        right = line[1].strip().split("|")

        print(left)
        print(right)

        self.__productions.append(Production(left, right))

    def print_menu(self):
        print("What do you want to see?\na) set of non terminals\nb) set of terminals\nc) start symbol\nd) set of productions\ne) set of "
              "productions for a given non terminal\nf) cfg check\nx) exit\n")
        opt = input(">")
        while opt != 'x':
            if opt == 'a':
                print(self.__non_terms
                      )
            if opt == 'b':
                print(self.__terms)
            if opt == 'c':
                print(self.__start_symbol)
            if opt == 'd':
                for one in self.__productions:
                    print(one)
            if opt == 'e':
                non_term = input("write your non term:")
                for one in self.__productions:
                    if non_term in one.lhs:
                        print(one)
            if opt == 'f':
                if self.check_CFG():
                    print("Grammar is CFG")
                else:
                    print("Grammar is not CFG")
            opt = input(">")

    def check_CFG(self):
        for prod in self.__productions:
            if len(prod.lhs) > 1:
                return False
        return True


# grammar = Grammar()
# grammar.read_grammar()
# grammar.print_menu()
