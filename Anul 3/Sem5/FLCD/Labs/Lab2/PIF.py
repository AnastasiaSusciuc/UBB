class PIF:
    def __init__(self):
        self.__content = []

    def add(self, token, pos):
        self.__content.append((token, pos))

    def __str__(self):
        result = ""
        for pair in self.__content:
            result += pair[0] + "->" + str(pair[1]) + "\n"
        return result
