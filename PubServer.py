###
# you can use another IP and port by providing them as arguments when executed from the terminal
###

from socket import *
import thread
import sys

from GUI import Display

class Server:
    DEFAULT_ADDR = ('127.0.0.1', 5555)

    def __init__(self, server_addr = DEFAULT_ADDR):
        thread.start_new_thread(self.network_loop, server_addr)

        self.customers = dict()

        self.GUI = Display(self)
        self.GUI.mainloop()

    def network_loop(self, name, port):
        server_addr = (name, port)
        server_socket = socket(AF_INET, SOCK_STREAM)    # create a socket
        try:    # attemps to bind to user specified address...
            server_socket.bind(server_addr)
        except: # ...if it was invalid just use default address
            print '[WARN]: Could not bind to address', server_addr, 'using default address', self.DEFAULT_ADDR
            server_addr = self.DEFAULT_ADDR
            server_socket.bind(server_addr) 
        server_socket.listen(1) # listen for connections
        print "Server is ready for clients to connect at:", server_addr

        while 1:
            connection_socket, addr = server_socket.accept()    # accept connection
            thread.start_new_thread(self.service_client, (connection_socket, addr))  # create a new thread to service the query

    def service_client(self, connection_socket, addr):
        request_message = connection_socket.recv(2048)
        print 'recieved request:', request_message, 'from:', addr
        connection_socket.send('rcv')
        connection_socket.close()
        user, order = self.format_request(request_message)
        self.customers[user] = connection_socket
        self.GUI.takeOrder(user, order)

    def format_request(self, request):
        request = request.split('\n\n')
        user = request[-2].split('from user: ')[1] # TODO
        request = request[1:-3]
        
        for item in request:
            item = item.split()

            word_index = 0 
            while word_index < len(item):
                if item[word_index] == 'with' or item[word_index] == 'Add':
                    item.insert(word_index, '\n\t')
                    word_index += 1
                word_index += 1
            
            order = ' '.join(item)

        return user, order

    def send_msg(self, customer_id, response):
        print 'sending', response, 'to', self.customers[customer_id]


if __name__=='__main__':
    addr = None

    # allow the user to specify another address
    if len(sys.argv) == 3:
        try:
            port = int(sys.argv[2])
            name = sys.argv[1]
            addr = (name, port)
        except: pass
        
    if addr:
        server = Server(addr)
    else:
        server = Server()