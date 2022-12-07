class Production:
    def __init__(self, lhs, rhs):
        self.lhs = lhs
        self.rhs = rhs

    def __str__(self) -> str:
        result = ""
        for el in self.lhs:
            result = result + el.strip()
            result += ", "

        result = result[:-2]

        result += " -> "

        for el in self.rhs:
            result = result + el.strip()
            result += " | "

        result = result[:-2]

        return result

