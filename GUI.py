from Tkinter import Tk, Button, Label, OptionMenu, StringVar
from ttk import Treeview

# TODO multi line orders still being cut off

class Display:
    def __init__(self, controller):
        self.controller = controller

        self.currIndex = 0

        # initialize the GUI
        self.app = Tk()
        self.app.title('Jack Magee\'s Pub')

        self.tree = Treeview(self.app, height=30)
        self.tree["columns"]=("one", "two", "three", "four")
        
        self.tree.column("one", width=200)
        self.tree.column("two", width=300)
        self.tree.column("three", width=200)
        self.tree.column("four", width=200)
        self.tree.heading("#0", text= "ID")
        self.tree.heading("one", text="Name")
        self.tree.heading("two", text="Order")
        self.tree.heading("three", text="Price")
        self.tree.heading("four", text="Respond (double-click)")

        self.tree.pack()
        
        self.tree.bind("<Double-1>", self.OnDoubleClick)

    def mainloop(self):
        self.app.mainloop()

    def OnDoubleClick(self, event):
        item = self.tree.selection()[0]
        response =  self.tree.item(item,"text")

        if response == 'rdy':
            parent = self.tree.parent(item)
            customer_id = self.tree.item(parent,"text")

            self.tree.delete(parent)
            self.controller.send_msg(customer_id, response)

    def takeOrder(self, customer_id, name, order, price):
        thisRow = str(self.currIndex)
        self.tree.insert("", self.currIndex, thisRow, text=customer_id, values=(name, "", "", ""))
        self.tree.insert(thisRow, 0, text='rdy', values=("", "", "", "Ready For Pick Up"))

        multiline_order = order.split('\n')
        this_line = 1
        for line in multiline_order[:-1]:
            if this_line == 1:
                self.tree.insert(thisRow, 1, text="order",values=("", order, price, ""))
            else:
                self.tree.insert(thisRow, this_line, text="order",values=("", line, "", ""))
            this_line += 1


        self.currIndex += 1
