from Lab2.PIF import PIF
from Lab2.symbol_table import SymbolTable
import re
from re import split


def get_tokens():
    return open('token.in', 'r').read().splitlines()


def split_string(string, delimiters):
    pattern = r'|'.join(delimiters)
    return split(pattern, string)


def isConstant(token):
    return re.match(r'^(0|[+-]?[1-9][0-9]*)$', token) is not None


def isIdentifier(token):
    return re.match(r'^[a-zA-Z]([a-zA-Z]|[0-9])*$', token) is not None


class Scanner:

    def __init__(self):
        self.__exceptionMessage = ""
        self.__symbol_table_identifiers = SymbolTable()
        self.__symbol_table_constants = SymbolTable()
        self.__pif = PIF()
        # self.operators = ["+", "-", ":=", ":<=", ":>=", ":>", ":<", "&&"]
        # self.separators = ["***", " ", ";", "(", ")", "[", "]"]
        # self.reservedWords = ["var", "integer", "read", "read", "write", "condition", "otherwise", "long_integer",
        #                       "step_loop", "string"]
        self.separators = []
        self.operators = []
        self.reservedWords = []

    def scan(self):
        self.get_tokens()
        lineCounter = 1

        with open('p1.txt') as reader:
            for line in reader:
                tokens = self.__tokenize(line)
                for i in range(len(tokens)):
                    if tokens[i] in self.reservedWords + self.separators + self.operators:
                        self.__pif.add(tokens[i], (-1, -1))
                    elif tokens[i] in self.operators and i < len(tokens) - 1:
                        if re.match("[1-9]", tokens[i + 1]):
                            self.__pif.add(tokens[i][:-1], (-1, -1))
                            continue
                        else:
                            self.__add_exception_message(tokens[i], lineCounter)
                    elif isIdentifier(tokens[i]):
                        hash_val, index = self.__symbol_table_identifiers.add(tokens[i])
                        self.__pif.add("id", (hash_val, index))
                    elif isConstant(tokens[i]):
                        hash_val, index = self.__symbol_table_constants.add(tokens[i])
                        self.__pif.add("const", (hash_val, index))
                    else:
                        self.__add_exception_message(tokens[i], lineCounter)
                lineCounter = lineCounter+1
        self.__write_scan_output()
        if self.__exceptionMessage == '':
            print("Lexically correct")
        else:
            print(self.__exceptionMessage)

    def __add_exception_message(self, token, line):
        self.__exceptionMessage += 'Lexical error at token \"' + token + '\" at line ' + str(line) + "\n"

    def __write_scan_output(self):
        with open('st_constants.out', 'w') as writer:
            writer.write(str(self.__symbol_table_constants.print_all_values()))

        with open('st_identifiers.out', 'w') as writer:
            writer.write(str(self.__symbol_table_identifiers.print_all_values()))

        with open('pif.out', 'w') as writer:
            writer.write(str(self.__pif))

    def isPartOfOperator(self, char):
        for op in self.operators:
            if char in op:
                return True
        return False

    def isPartOfSeparator(self, char):
        for op in self.separators:
            if char in op:
                return True
        return False

    def getOperatorToken(self, line, index):
        token = ''

        while index < len(line) and self.isPartOfOperator(line[index]):
            token += line[index]
            index += 1

        return token, index

    def getStringToken(self, line, index):
        token = ''
        quotes = 0

        while index < len(line) and quotes < 2:
            if line[index] == '\'':
                quotes += 1
            token += line[index]
            index += 1

        return token, index

    def __tokenize(self, line):
        token = ''
        index = 0
        tokens = []
        while index < len(line):
            if self.isPartOfOperator(line[index]):
                if token:
                    tokens.append(token)
                token, index = self.getOperatorToken(line, index)
                tokens.append(token)
                token = ''

            elif line[index] == '\"':
                if token:
                    tokens.append(token)
                token, index = self.getStringToken(line, index)
                tokens.append(token)
                token = ''

            elif line[index] in self.separators:
                if token:
                    tokens.append(token)
                token, index = line[index], index + 1
                tokens.append(token)
                token = ''
            else:
                token += line[index]
                index += 1
        if token:
            tokens.append(token)

        tokens = list(filter(" ".__ne__, tokens))
        tokens = list(filter("\n".__ne__, tokens))

        return tokens

    def get_tokens(self):
        lineCounter = 0
        with open('token.in') as reader:
            for line in reader:
                line = line.replace('\n', '')
                if lineCounter < 7:
                    self.separators.append(line)
                elif lineCounter < 19:
                    self.operators.append(line)
                else:
                    self.reservedWords.append(line)
                lineCounter = lineCounter+1
        if " " not in self.separators:
            self.separators.append(" ")


Scanner().scan()
