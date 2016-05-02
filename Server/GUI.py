from Tkinter import Tk, Button, Label, OptionMenu, StringVar
from ttk import Treeview

# A GUI for a food ordering server. Displayed as a tree view. Responses to clients can be sent by double clicking
# response fields

class Display:
    def __init__(self, controller):
        self.controller = controller

        self.currIndex = 0

        # initialize the GUI
        self.app = Tk()
        self.app.title('Jack Magee\'s Pub')

        self.tree = Treeview(self.app, height=30)
        
        # name the tree columns, not sure if they have to be named numbers but that's how the example did it
        self.tree["columns"]=("one", "two", "three", "four")
        
        # set the column widths
        self.tree.column("one", width=200)
        self.tree.column("two", width=300)
        self.tree.column("three", width=200)
        self.tree.column("four", width=200)

        # set the column headings
        self.tree.heading("#0", text= "ID")
        self.tree.heading("one", text="Name")
        self.tree.heading("two", text="Order")
        self.tree.heading("three", text="Price")
        self.tree.heading("four", text="Respond (double-click)")

        self.tree.pack()
        
        # register handler for double-clicks
        self.tree.bind("<Double-1>", self.OnDoubleClick)

    def mainloop(self):
        self.app.mainloop()

    # this is like making tree entries buttons
    def OnDoubleClick(self, event):
        # get the pressed item
        item = self.tree.selection()[0]
        # get the item's text
        response =  self.tree.item(item,"text")

        # this is the only response we are sending for now
        if response == 'rdy':
            # get the parent directory whose text is the customer id
            parent = self.tree.parent(item)
            customer_id = self.tree.item(parent,"text")
            # remove it from the tree
            self.tree.delete(parent)
            # send the message to the customer
            self.controller.send_msg(customer_id, response)

    # add a new order to the tree
    def takeOrder(self, customer_id, name, order, price):
        # just a row identifier
        thisRow = str(self.currIndex)

        # insert the i.d. and name at the top level
        self.tree.insert("", self.currIndex, thisRow, text=customer_id, values=(name, "", "", ""))
        # insert the "button" for sending notification to clients
        self.tree.insert(thisRow, 0, text='rdy', values=("", "", "", "Ready For Pick Up"))

        # this is a hacky solution to get multiline orders to appear because treeviews will 
        # crop anything more than 1 line so I just make a new entry for every line
        multiline_order = order.split('\n')
        this_line = 1
        for line in multiline_order[:-1]:   # exclude the last end line
            if this_line == 1:  # the first line has the name of the order and it's price
                self.tree.insert(thisRow, 1, text="order",values=("", order, price, ""))
            else: # just keep printing the extra options, sides, and add ons
                self.tree.insert(thisRow, this_line, text="order",values=("", line, "", ""))
            this_line += 1

        self.currIndex += 1
