import zmq
import time

def client(client_id):
    context = zmq.Context()
    socket = context.socket(zmq.REQ)
    socket.connect("tcp://localhost:5555")

    for request in range(10):
        message = f"Klient {client_id} żądanie {request}"
        print(f"Klient {client_id} wysyła: {message}")
        socket.send_string(message)

        response = socket.recv()
        print(f"Klient {client_id} otrzymał: {response.decode()}")

        time.sleep(1)

if __name__ == "__main__":
    client_id = 2
    client(client_id)