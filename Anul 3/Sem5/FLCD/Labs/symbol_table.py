class SymbolTable:
    def __init__(self):
        self.__alphabet = [
            '_', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
            'u', 'v', 'w', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
            'U', 'V', 'W', 'X', 'Y', 'Z',
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '"',
        ]
        self.__power = 191
        self.__hash_modulo = 997
        self.__hash_table = [[] for _ in range(self.__hash_modulo + 5)]

    def __find_hash_value(self, x):
        str_x = str(x)
        hash_value = 0
        for char in str_x:
            hash_value = (hash_value * self.__power + ord(char)) % self.__hash_modulo
        return hash_value

    def add(self, key):
        hash_value = self.__find_hash_value(key)

        if key not in self.__hash_table[hash_value]:
            self.__hash_table[hash_value].append(key)

        return hash_value, self.__hash_table[hash_value].index(key)


identifierST = SymbolTable()
constantsST = SymbolTable()

identifiers = ["variable", "ana", "apples", "chocolates"]
constants = [0, 1, 2, 2.5, 5.555]

for val in identifiers:
    print(val, identifierST.add(val), identifierST.add(val))

for val in constants:
    print(val, constantsST.add(val), constantsST.add(val))
