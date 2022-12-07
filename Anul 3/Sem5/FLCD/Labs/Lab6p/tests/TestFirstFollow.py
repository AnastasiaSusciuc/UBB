import unittest

from Grammar import Grammar
from Parser import Parser


class MyTestCase(unittest.TestCase):
    def test_first_g1(self):
        grammar = Grammar("g_test1.txt")
        parser = Parser(grammar)

        # first(S) should be {"int", "("}
        self.assertEqual(len(parser.first_set["S"]), 2)
        self.assertTrue("int" in parser.first_set["S"])
        self.assertTrue("(" in parser.first_set["S"])

        # first(A) should be {"int", "("}
        self.assertEqual(len(parser.first_set["A"]), 2)
        self.assertTrue("int" in parser.first_set["A"])
        self.assertTrue("(" in parser.first_set["A"])

        # first(B) should be {"+", "E"}
        self.assertEqual(len(parser.first_set["B"]), 2)
        self.assertTrue("+" in parser.first_set["B"])
        self.assertTrue("E" in parser.first_set["B"])

        # first(C) should be {"*", "E"}
        self.assertEqual(len(parser.first_set["C"]), 2)
        self.assertTrue("*" in parser.first_set["C"])
        self.assertTrue("E" in parser.first_set["C"])

    def test_first_g2(self):
        grammar = Grammar("g_test2.txt")
        parser = Parser(grammar)

        # first(S) should be {"int", "(", "+", "E"}
        self.assertEqual(len(parser.first_set["S"]), 4)
        self.assertTrue("int" in parser.first_set["S"])
        self.assertTrue("(" in parser.first_set["S"])
        self.assertTrue("+" in parser.first_set["S"])
        self.assertTrue("E" in parser.first_set["S"])

        # first(A) should be {"int", "(", "+", "E"}
        self.assertEqual(len(parser.first_set["A"]), 4)
        self.assertTrue("int" in parser.first_set["A"])
        self.assertTrue("(" in parser.first_set["A"])
        self.assertTrue("+" in parser.first_set["A"])
        self.assertTrue("E" in parser.first_set["A"])

        # first(B) should be {"+", "E"}
        self.assertEqual(len(parser.first_set["B"]), 2)
        self.assertTrue("+" in parser.first_set["B"])
        self.assertTrue("E" in parser.first_set["B"])

        # first(C) should be {"*", "E"}
        self.assertEqual(len(parser.first_set["C"]), 2)
        self.assertTrue("*" in parser.first_set["C"])
        self.assertTrue("E" in parser.first_set["C"])

    def test_follow_g1(self):
        grammar = Grammar("g_test1.txt")
        parser = Parser(grammar)

        # follow(S) should be {")", "E"}
        self.assertEqual(len(parser.follow_set["S"]), 2)
        self.assertTrue(")" in parser.follow_set["S"])
        self.assertTrue("E" in parser.follow_set["S"])

        # follow(A) should be {")", "E", "+"}
        self.assertEqual(len(parser.follow_set["A"]), 3)
        self.assertTrue(")" in parser.follow_set["A"])
        self.assertTrue("E" in parser.follow_set["A"])
        self.assertTrue("+" in parser.follow_set["A"])

        # follow(B) should be {")", "E"}
        self.assertEqual(len(parser.follow_set["B"]), 2)
        self.assertTrue(")" in parser.follow_set["B"])
        self.assertTrue("E" in parser.follow_set["B"])

        # follow(C) should be {")", "E", "+"}
        self.assertEqual(len(parser.follow_set["C"]), 3)
        self.assertTrue(")" in parser.follow_set["C"])
        self.assertTrue("E" in parser.follow_set["C"])
        self.assertTrue("+" in parser.follow_set["C"])


if __name__ == '__main__':
    unittest.main()
