#!/usr/bin/env python

###
# you can use another IP and port by providing them as arguments when executed from the terminal
###

# TODO send last thirty entries either out of all or with certain name

from socket import *
import thread
import sys

from GUI import Display

class Server:
    DEFAULT_ADDR = ('127.0.0.1', 5555)

    def __init__(self, server_addr = DEFAULT_ADDR):
        # run network connections in it's own thread
        thread.start_new_thread(self.network_loop, server_addr)

        # store all of the connections so they can be responded to
        self.customers = dict()
        self.order_database = []

        # create and run the gui
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
            thread.start_new_thread(self.service_client, (connection_socket, addr))  # create a new thread to service a client

    # TODO comment
    def service_client(self, connection_socket, addr):
        request_message = connection_socket.recv(2048)  # read the data from the client
        print 'recieved request:', request_message, 'from:', addr
        
        if request_message != '':
            if request_message.split()[0] == 'qry':
                if len(request_message.split()):
                    response = self.query_response(' '.join(request_message.split()[1:]))
                else:
                    response = self.query_response()

                if response == '': response = 'emt'
                print response
                connection_socket.send('qry;' + response)
            else:
                connection_socket.send('rcv')   # let the client know that its order was recieved
                # parse the message
                user, name, order, price = self.parse_request(request_message)
                # store the customer's information for later contact
                self.customers[user] = connection_socket
                # update the GUI
                self.GUI.takeOrder(user, name, order, price)

    #################################################################################################################################
    #   parse the request. The request format is defined as such:                                                                   #
    #                                                                                                                               #
    #   [                                                                                                                           #
    #                                                                                                                               #
    #   <order name> <{optional}with [side]> <{optional}Add [topping]>, <{optional}Add [topping]>, ...., <{optional}Add [topping]>  #
    #                                                                                                                               #
    #   <order name> <{optional}with [side]> <{optional}Add [topping]>, <{optional}Add [topping]>, ...., <{optional}Add [topping]>  #
    #   .                                                                                                                           #
    #   .                                                                                                                           #
    #   .                                                                                                                           #
    #                                                                                                                               #
    #   Price: <price>                                                                                                              #
    #                                                                                                                               #
    #   Name: <name>                                                                                                                #
    #                                                                                                                               #
    #   Bowdoin I.D.: <i.d.>                                                                                                        #
    #                                                                                                                               #
    #   ]                                                                                                                           #
    #################################################################################################################################
    def parse_request(self, request):
        # split it into its constituent parts
        request = request.split('\n\n')

        # these fields are garuanteed
        price = request[-4].split('Price: ')[1]
        name = request[-3].split('Name: ')[1]
        user = request[-2].split('Bowdoin I.D.: ')[1]
        
        # this is the order part of the message
        request = request[1:-4]

        self.store_in_database(name, request)   # store the order
        
        # parse the order

        order = ''
        for item in request:    # each item in the order
            item = item.split() # split into words

            #######################################################################################################
            # loop through all the words and format the sides and toppings to be easily seen separately like such #
            #                                                                                                     #
            # <name>                                                                                              #
            #       <side>                                                                                        #
            #       <topping>                                                                                     #
            #######################################################################################################
            word_index = 0
            while word_index < len(item):
                if item[word_index] == 'with' or item[word_index] == 'Add':
                    item.insert(word_index, '\n\t')
                    word_index += 1
                word_index += 1
            
            # join it back into one string
            order += ' '.join(item) + '\n'

        return user, name, order, price

    # TODO comment
    def store_in_database(self, name, request):
        for item in request:
            self.order_database.append((name, item))
    # TODO comment
    def query_response(self, name=None):
        MAX_RESPONSE_SIZE = 30  # TODO test this value
        curr_response_size = 0

        response = ''

        for index in reversed(range(len(self.order_database))):
            if curr_response_size >= MAX_RESPONSE_SIZE: break

            this_item = self.order_database[index]

            # format the response: name:item;name:item;.... for ease of parsing in the clients
            if not name or this_item[0] == name:
                response += this_item[0] + ':' + this_item[1] + ';'
                curr_response_size += 1

        return response

    # send a message to a customer. We only need to do this once so then the connection can be closed
    def send_msg(self, customer_id, response):
        if customer_id in self.customers.keys():
            print 'sending', response, 'to', self.customers[customer_id]
            self.customers[customer_id].send(response)
            self.customers[customer_id].close()
            del self.customers[customer_id]

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