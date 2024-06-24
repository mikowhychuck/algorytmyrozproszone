import zmq

context = zmq.Context()

client_socket = context.socket(zmq.REQ)

client_socket.curve_secretkey = b"]mlIqmo^MzAnIcaXg/xwpJ^[XuTKtrFq-+<-Y6KP"
client_socket.curve_publickey = b"]d0[7{t]/BRe?mu1$O][})bXurB3#x*riL&{X@uo"
client_socket.curve_serverkey = b"I2gR[Y>AWRU<S{VAY9!9}>dwGr%D(v^BeL5u^f=V"

client_socket.connect("tcp://localhost:5555")

client_socket.send_string("a ku ku 1")
message = client_socket.recv_string()
print(f"Received: {message}")

client_socket.close()
context.term()
