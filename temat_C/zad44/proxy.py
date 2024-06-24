import zmq

context = zmq.Context()

frontend = context.socket(zmq.ROUTER)
frontend.bind("tcp://*:5555")

backend = context.socket(zmq.DEALER)
backend.bind("tcp://*:5556")

try:
    zmq.proxy(frontend, backend)
except Exception as e:
    print(f"Proxy error: {e}")
finally:
    frontend.close()
    backend.close()
    context.term()

