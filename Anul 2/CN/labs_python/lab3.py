import socket
import struct

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    s.connect(('192.168.0.255', 1234))
except socket.error as err:
    print(err)
    exit(1)

s.send(b'Hello space another one!')

shortBytes = s.recv(2)
ans = struct.unpack('!h', shortBytes)
print(ans[0])

s.close()
