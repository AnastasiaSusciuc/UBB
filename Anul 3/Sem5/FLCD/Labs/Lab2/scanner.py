from Lab2.PIF import PIF
from Lab2.symbol_table import SymbolTable
import re


class Scanner:

    def __init__(self):
        self.__exception_message = ""
        self.__symbol_table_identifiers = SymbolTable()
        self.__symbol_table_constants = SymbolTable()
        self.__pif = PIF()
        # self.operators = ["+", "-", ":=", ":<=", ":>=", ":>", ":<", "&&"]
        # self.separators = ["***", " ", ";", "(", ")", "[", "]"]
        # self.reserved_words = ["var", "integer", "read", "read", "write", "condition", "otherwise", "long_integer",
        #                       "step_loop", "string"]
        self.separators = []
        self.operators = []
        self.reserved_words = []

    def scan(self):
        self.__get_tokens()
        lineCounter = 1

        with open('input_programs/perr.txt') as reader:
            for line in reader:
                tokens = self.__tokenize(line)
                for i in range(len(tokens)):
                    if tokens[i] in self.reserved_words + self.separators + self.operators:
                        self.__pif.add(tokens[i], (-1, -1))
                    elif tokens[i] in self.operators and i < len(tokens) - 1:
                        if re.match("[1-9]", tokens[i + 1]):
                            self.__pif.add(tokens[i][:-1], (-1, -1))
                            continue
                        else:
                            self.__add_exception_message(tokens[i], lineCounter)
                    elif self.__is_identifier(tokens[i]):
                        hash_val, index = self.__symbol_table_identifiers.add(tokens[i])
                        self.__pif.add("id", (hash_val, index))
                    elif self.__is_constant(tokens[i]):
                        hash_val, index = self.__symbol_table_constants.add(tokens[i])
                        self.__pif.add("const", (hash_val, index))
                    else:
                        self.__add_exception_message(tokens[i], lineCounter)
                lineCounter = lineCounter+1
        self.__write_scan_output()
        if self.__exception_message == '':
            print("Lexically correct")
        else:
            print(self.__exception_message)

    def __is_constant(self, token):
        return re.match(r'^(0|[+-]?[1-9][0-9]*)$|^([+-]?[1-9][0-9]*\.[0-9]*$)', token) is not None

    def __is_identifier(self, token):
        return re.match(r'^_?[a-zA-Z]([a-zA-Z]|[0-9])*$', token) is not None

    def __inside_operator(self, char):
        for op in self.operators:
            if char in op:
                return True
        return False

    def __add_exception_message(self, token, line):
        self.__exception_message += 'Lexical error at token \"' + token + '\" at line ' + str(line) + "\n"

    def __write_scan_output(self):
        with open('scanner_output/st_constants.out', 'w') as writer:
            writer.write(str(self.__symbol_table_constants.print_all_values()))

        with open('scanner_output/st_identifiers.out', 'w') as writer:
            writer.write(str(self.__symbol_table_identifiers.print_all_values()))

        with open('scanner_output/pif.out', 'w') as writer:
            writer.write(str(self.__pif))

    def __get_operator_token(self, line, index):
        token = ''
        while index < len(line) and self.__inside_operator(line[index]):
            token += line[index]
            index += 1

        return token, index

    def __get_string_token(self, line, index):
        token = ''
        quotes = 0

        while index < len(line) and quotes < 2:
            if line[index] == '\'' or line[index] == '\"':
                quotes += 1
            token += line[index]
            index += 1

        return token, index

    def __tokenize(self, line):
        token = ''
        index = 0
        tokens = []
        while index < len(line):
            if self.__inside_operator(line[index]):
                if token:
                    tokens.append(token)
                token, index = self.__get_operator_token(line, index)
                tokens.append(token)
                token = ''

            elif line[index] == '\"':
                if token:
                    tokens.append(token)
                token, index = self.__get_string_token(line, index)
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

    def __get_tokens(self):
        lineCounter = 0
        with open('token.in') as reader:
            for line in reader:
                line = line.replace('\n', '')
                if lineCounter < 7:
                    self.separators.append(line)
                elif lineCounter < 19:
                    self.operators.append(line)
                else:
                    self.reserved_words.append(line)
                lineCounter = lineCounter+1
        if " " not in self.separators:
            self.separators.append(" ")


Scanner().scan()
