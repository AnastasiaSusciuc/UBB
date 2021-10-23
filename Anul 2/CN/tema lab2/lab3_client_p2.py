import socket
import sys
import struct
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_address = ('192.168.1.139', 4321)

msg = input("Full path of file:")

l = socket.htonl(len(msg))
s.connect(server_address)
s.send(msg.encode())

length = s.recv(4)
answer = struct.unpack('!i', length)
print("Length of output: ", answer[0])
if answer[0] == -1:
    print("The file does not exist!! Recieved -1")
else:

    message = s.recv(answer[0])
    decoded_message = message.decode('ascii')
    print("Message: \n", decoded_message)

    shortBytes = s.recv(4)
    ex = struct.unpack('!i', shortBytes)
    print("Exitcode : ", ex[0])

    filename = msg.split('/')[-1]
    filename += '-copy'
    outF = open(filename, "w")
    outF.write(decoded_message)
