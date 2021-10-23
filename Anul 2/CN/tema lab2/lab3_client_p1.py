import socket
import sys
import struct
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_address = ('192.168.1.139', 4321)

msg = input("Command:")

l = socket.htonl(len(msg))
msg += '\0'
s.connect(server_address)

# s.send(str(l).encode())

s.send(msg.encode())

length = s.recv(4)
answer = struct.unpack('!i', length)
print("Length of output: ", answer[0])
message = s.recv(answer[0])
print("Message: \n", message.decode('ascii'))

shortBytes = s.recv(4)
ex = struct.unpack('!i', shortBytes)
print("Exitcode : ", ex[0])
