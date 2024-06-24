import zmq
import numpy as np
import pickle

def generate_matrices(num_matrices):
    matrices = []
    for i in range(num_matrices):
        matrix = np.random.randint(1, 11, size=(3, 3))
        matrices.append(matrix)
    return matrices

def main():
    context = zmq.Context()
    socket = context.socket(zmq.REQ)
    socket.connect("tcp://localhost:5555")

    matrices = generate_matrices(3)  
    matrices_data = pickle.dumps(matrices)
    socket.send(matrices_data)

    result_data = socket.recv()
    result_matrices = pickle.loads(result_data)
    print("Otrzymane wynikowe macierze:")
    for matrix in result_matrices:
        print(matrix)

if __name__ == "__main__":
    main()
