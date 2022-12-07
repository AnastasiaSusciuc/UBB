from Lab4.Grammar import Grammar
from Lab6.domain.parser import Parser


class UI:

    def __init__(self, parser):
        self.parser1 = parser
        self.evaluateG1()

    def evaluateG1(self):
        print(self.parser1.firstSet)
        # print(self.parser1.followSet)


UI = UI(Parser(Grammar()))




