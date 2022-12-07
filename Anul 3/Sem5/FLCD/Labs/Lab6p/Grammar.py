from Production import Production


class Grammar:
    def __init__(self, file_path):
        self.non_terms = []
        self.terms = []
        self.productions = []
        self.start_symbol = None
        self.file_path = file_path
        self.read_grammar()

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
        self.non_terms = line.split()

    def __read_terms(self, line):
        self.terms = line.split()

    def __read_start_sym(self, line):
        self.start_symbol = line.strip()

    def __read_productions(self, line):
        line = line.split("->")
        left = line[0].split()
        right = line[1].strip().split("|")
        self.productions.append(Production(left, right))

    def check_CFG(self):
        for prod in self.productions:
            if len(prod.lhs) > 1:
                return False
        return True
