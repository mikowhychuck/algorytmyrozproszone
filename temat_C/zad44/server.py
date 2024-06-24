import zmq
import time
import random

def server(server_id):
    context = zmq.Context()
    socket = context.socket(zmq.ROUTER)
    socket.connect("tcp://localhost:5556")

    while True:
        try:
            # Receive multi-part message
            frames = socket.recv_multipart()

            if len(frames) < 2:
                print("Received incomplete message")
                continue

            # First frame is the identity
            identity = frames[0]

            # Remaining frames are the message parts
            message_parts = frames[1:]

            for part in message_parts:
                decoded_message = part.decode('utf-8')
                print(f"Serwer {server_id} otrzymał: {decoded_message}")

            # Wysyłanie wielu odpowiedzi
            num_responses = random.randint(1, 5)  # Liczba odpowiedzi od 1 do 5
            for i in range(num_responses):
                response = f"Serwer {server_id} odpowiedź {i+1}"
                if i == num_responses - 1:
                    response += " (ostatnia)"
                socket.send_multipart([identity, response.encode('utf-8')])
                print(f"Serwer {server_id} wysłał: {response}")
                time.sleep(0.5)
        except zmq.ZMQError as e:
            print(f"Error receiving/sending message: {e}")

if __name__ == "__main__":
    server_id = 1
    server(server_id)
