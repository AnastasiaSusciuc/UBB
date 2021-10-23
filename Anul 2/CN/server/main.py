import socket
import struct
import os

welcome = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
welcome.bind(('0.0.0.0', 4321))
welcome.listen(10)

while True:
    comm, addr = welcome.accept()
    print("Connection from: ", addr)

    cmd = comm.recv(1000)
    cmd = cmd.decode('ascii')

    print("Am primit: " + cmd)

    print(type(cmd))

    cmd = "git --version"

    returned_value = os.system(cmd)

    print(returned_value)

    answerBytes = struct.pack('!i', returned_value)
    comm.send(answerBytes)
    comm.close()

welcome.close()
