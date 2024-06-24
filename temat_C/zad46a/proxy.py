# proxy.py
import zmq

def main():
    context = zmq.Context()

    frontend = context.socket(zmq.DEALER)
    backend = context.socket(zmq.ROUTER)

    # Konfiguracja CurveZMQ na froncie (DEALER)
    frontend.curve_server = True
    frontend.curve_secretkey = b"]mlIqmo^MzAnIcaXg/xwpJ^[XuTKtrFq-+<-Y6KP"
    frontend.curve_publickey = b"]d0[7{t]/BRe?mu1$O][})bXurB3#x*riL&{X@uo"

    # Konfiguracja CurveZMQ na tyłach (ROUTER)
    backend.curve_server = True
    backend.curve_secretkey = b"kB4G-iB>yFzo]2Wov&K-@GQwr6mO9MRjR$jDE%6h"
    backend.curve_publickey = b"I2gR[Y>AWRU<S{VAY9!9}>dwGr%D(v^BeL5u^f=V"

    # Bind i connect
    frontend.bind("tcp://*:5555")
    backend.bind("tcp://*:5556")

    # Utwórz proxy
    zmq.proxy(frontend, backend)

    # Zamknij sockety i zakończ
    frontend.close()
    backend.close()
    context.term()

if __name__ == "__main__":
    main()
