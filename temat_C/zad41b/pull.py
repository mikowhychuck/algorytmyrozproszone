import zmq
context = zmq.Context()

socket = context.socket(zmq.PULL)

socket.connect("tcp://localhost:8888")

while True:
    message = socket.recv_string()
    print(f"PULL received: {message}")
