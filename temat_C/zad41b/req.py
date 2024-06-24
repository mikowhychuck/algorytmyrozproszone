import zmq

context = zmq.Context()

socket = context.socket(zmq.REQ)
socket.connect("tcp://localhost:7777")

socket.send(b"Hejka naklejka")

message = socket.recv()
print("otrzymana odpowiedź: %s" % (message))

    
