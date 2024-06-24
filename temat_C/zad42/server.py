import zmq
import numpy as np
import pickle

constant_factor = 2.0

def handle_matrices(matrices_data):
    matrices = pickle.loads(matrices_data)
    print(f"Otrzymane dane: {matrices}")
    result_matrices = [constant_factor * matrix for matrix in matrices]
    result_data = pickle.dumps(result_matrices)
    return result_data

def main():
    context = zmq.Context()
    socket = context.socket(zmq.REP)
    socket.bind("tcp://*:5555")

    while True:
        matrices_data = socket.recv()
        result_data = handle_matrices(matrices_data)
        socket.send(result_data)

if __name__ == "__main__":
    main()
