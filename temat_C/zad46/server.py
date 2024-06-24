import zmq
import zmq.auth
from zmq.auth.thread import ThreadAuthenticator

context = zmq.Context()

server_socket = context.socket(zmq.REP)

server_socket.curve_secretkey = b"kB4G-iB>yFzo]2Wov&K-@GQwr6mO9MRjR$jDE%6h"
server_socket.curve_publickey = b"I2gR[Y>AWRU<S{VAY9!9}>dwGr%D(v^BeL5u^f=V"
server_socket.curve_server = True

server_socket.bind("tcp://*:7777")

while True:
    message = server_socket.recv_string()
    print(f"Received: {message}")
    server_socket.send_string(f"Odp na: {message}")
