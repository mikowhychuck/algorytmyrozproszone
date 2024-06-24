import zmq

context = zmq.Context()
socket = context.socket(zmq.SUB)
socket.connect("tcp://localhost:9999")
topic = "news"
socket.setsockopt_string(zmq.SUBSCRIBE, topic)

try:
    while True:
        message = socket.recv_string()
        print(f"SUB received: {message}")

except KeyboardInterrupt:
    print("Interrupted by user")

finally:
    socket.close()
    context.term()