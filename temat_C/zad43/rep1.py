import zmq
import time

def server(server_id):
    context = zmq.Context()
    socket = context.socket(zmq.REP)
    socket.connect("tcp://localhost:5556")

    while True:
        message = socket.recv()
        print(f"Serwer {server_id} otrzymał: {message.decode()}")

        time.sleep(1)

        socket.send_string(f"Serwer {server_id} odpowiedział")

if __name__ == "__main__":
    server_id = 1 
    server(server_id)
