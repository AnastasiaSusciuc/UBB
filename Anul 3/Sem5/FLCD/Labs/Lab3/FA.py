class FA:
    def __init__(self, file_path):
        self.file_path = file_path
        self.Q = []
        self.Sigma = []
        self.q0 = 0
        self.qf = []
        self.P = {}
        self.__commands = {}
        self.__read_FA_from_file()
        # self.__build_menu()

    def get_states(self):
        return self.Q

    def get_alphabet(self):
        return self.Sigma

    def get_initial_state(self):
        return self.q0

    def get_final_states(self):
        return self.qf

    def get_productions(self):
        return self.P

    def __build_menu(self):
        self.__commands[0] = ("set of states", self.get_states)
        self.__commands[1] = ("alphabet", self.get_alphabet)
        self.__commands[2] = ("initial state", self.get_initial_state)
        self.__commands[3] = ("set of final states", self.get_final_states)
        self.__commands[4] = ("set of productions", self.get_productions)
        self.__commands['x'] = ("exit", "")
        self.display_menu()

    def display_menu(self):
        print("Press")
        for key in self.__commands.keys():
            print(str(key) + " to print " + self.__commands[key][0])

        user_input = ""
        while user_input != "x":
            user_input = input("Introduce your choise:")

            if user_input == "x":
                break
            if int(user_input) not in self.__commands.keys():
                print("Invalid input!")

            print(self.__commands[int(user_input)][1]())

    def __read_FA_from_file(self):
        lineCounter = 0
        with open(self.file_path) as reader:
            for line in reader:
                line = line.replace('\n', '')
                if lineCounter == 0:
                    self.__read_states(line)
                elif lineCounter == 1:
                    self.__read_alphabet(line)
                elif lineCounter == 2:
                    self.__read_initial_state(line)
                elif lineCounter == 3:
                    self.__read_final_states(line)
                elif lineCounter == 4:
                    pass
                else:
                    self.__read_productions(line)

                lineCounter = lineCounter+1

    def is_DFA(self):
        for key in self.P.keys():
            if len(self.P[key]) > 1:
                return False
        return True

    def isAccepted(self, seq):
        if self.is_DFA():
            crt = self.q0
            for symbol in seq:
                if (crt, symbol) in self.P.keys():
                    crt = self.P[(crt, symbol)][0]
                else:
                    return False
            return crt in self.qf
        return False

    def __read_states(self, line):
        line = line.split(" ")
        if len(line) <= 2:
            raise Exception("Set of states is not valid!")
        self.Q = line[2:]

    def __read_alphabet(self, line):
        line = line.split(" ")
        if len(line) <= 2:
            raise Exception("Alphabet is not valid!")
        self.Sigma = line[2:]

    def __read_initial_state(self, line):
        line = line.split(" ")
        if len(line) != 3:
            raise Exception("Initial state is not valid!")
        if line[2] not in self.Q:
            raise Exception("Initial state is not in the set of states!")
        self.q0 = line[2]

    def __read_final_states(self, line):
        line = line.split(" ")
        if len(line) <= 2:
            raise Exception("Set of Final states is not valid!")
        for qf in line[2:]:
            if qf not in self.Q:
                raise Exception("A final state is not in the set of states!")

        self.qf = line[2:]

    def __read_productions(self, line):
        line = line.split(" ")
        if len(line) <= 2:
            raise Exception("A production is not valid!" + str(line))
        if line[0] not in self.Q or line[2] not in self.Q:
            raise Exception("invalid state in the set of productions")

        if line[1] not in self.Sigma:
            raise Exception("invalid literal in the set of productions")

        if (line[0], line[1]) in self.P.keys():
            self.P[(line[0], line[1])].append(line[2])
        else:
            self.P[(line[0], line[1])] = [line[2]]


# fa = FA("./../Lab3/FA_values/FA_constants.in")
# print(fa.isAccepted("123"))
# print(fa.isAccepted("023"))
# print(fa.isAccepted("19820"))
# print(fa.isAccepted("19.9738"))
# print(fa.isAccepted("-132.01"))
# print(fa.isAccepted("+49300.0"))
# print(fa.isAccepted("0.8748"))
# print(fa.isAccepted("928"))
# print(fa.isAccepted("-022.93"))