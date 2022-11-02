class SymbolTable:
    def __init__(self):
        self.__power = 191
        self.__hash_modulo = 997
        self.__hash_table = [[] for _ in range(self.__hash_modulo + 5)]

    def __find_hash_value(self, x):
        """
        computes the hash value
        :param x: the value to be hashed
        :return: the hash value
        """
        str_x = str(x)
        hash_value = 0
        for char in str_x:
            hash_value = (hash_value * self.__power + ord(char)) % self.__hash_modulo
        return hash_value

    def add(self, key):
        """
        adds an element into the hashtable
        :param key: the value of the element
        :return: the hash value and the position of the element in its list
        """
        hash_value = self.__find_hash_value(key)

        if key not in self.__hash_table[hash_value]:
            self.__hash_table[hash_value].append(key)

        return hash_value, self.__hash_table[hash_value].index(key)

    def remove(self, key):
        """
        removes the key from hashtable
        :param key: the element to be removed
        :return: the hash value
        """
        hash_value = self.__find_hash_value(key)
        if key in self.__hash_table[hash_value]:
            self.__hash_table[hash_value].remove(key)

        return hash_value

    def exists(self, key):
        """
        :param key: the element we are looking for
        :return: True if key is inside the hash table
        """
        hash_value = self.__find_hash_value(key)
        return key in self.__hash_table[hash_value]

    def print_all_values(self):
        """
        prints all the keys inside the hashtable
        :return: -
        """
        list_all_keys = []
        for i in range(self.__hash_modulo):
            for key in self.__hash_table[i]:
                list_all_keys.append(key)
        return  list_all_keys


# identifierST = SymbolTable()
# constantsST = SymbolTable()
#
# identifiers = ["variable", "ana", "apples", "chocolates"]
# constants = [0, 1, 2, 2.5, 5.555]
#
# for val in identifiers:
#     identifierST.add(val)
#
# identifierST.print_all_values()
#
# print("AFTER REMOVAL")
# identifierST.remove(identifiers[0])
# identifierST.print_all_values()
