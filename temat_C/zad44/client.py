import zmq
import time

def client(client_id):
    context = zmq.Context()
    socket = context.socket(zmq.DEALER)
    socket.setsockopt(zmq.IDENTITY, str(client_id).encode('utf-8'))  # Dodanie identyfikatora klienta
    socket.connect("tcp://localhost:5555")

    poller = zmq.Poller()
    poller.register(socket, zmq.POLLIN)

    for request in range(10):
        message = f"client {client_id} request {request}"
        print(f"Klient {client_id} wysyła: {message}")
        socket.send_string(message)

        # Receive and print all parts of the response
        while True:
            socks = dict(poller.poll(1000))  # Oczekiwanie do 1 sekundy na odpowiedź
            if socket in socks and socks[socket] == zmq.POLLIN:
                try:
                    parts = socket.recv_multipart()
                    if len(parts) >= 2:
                        identity, response = parts[0], parts[1]
                        print(f"Response received: {response}")
                        decoded_response = response.decode('utf-8')
                        print(f"Klient {client_id} otrzymał: {decoded_response}")
                        if "(ostatnia)" in decoded_response:
                            break  # Exit the loop when the last response part is received
                except zmq.ZMQError as e:
                    print(f"Error receiving response: {e}")
            else:
                print("Brak odpowiedzi, oczekiwanie...")
        time.sleep(1)

if __name__ == "__main__":
    client_id = 1
    client(client_id)
