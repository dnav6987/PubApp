from Tkinter import Tk, Button, Label, OptionMenu, StringVar
from ttk import Treeview

class Display:
    def __init__(self, controller):
        self.controller = controller

        self.currIndex = 0

        # initialize the GUI
        self.app = Tk()
        self.app.title('Jack Magee\'s Pub')

        self.tree = Treeview(self.app, height=30)
        self.tree["columns"]=("one", "two")
        
        self.tree.column("one", width=750 )
        self.tree.column("two", width=200)
        self.tree.heading("#0", text= "ID")
        self.tree.heading("one", text="Orders")
        self.tree.heading("two", text="Responses (double-click)")

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


    def takeOrder(self, customer_id, order):
        thisRow = str(self.currIndex)
        self.tree.insert("", self.currIndex, thisRow, text=customer_id)
        self.tree.insert(thisRow, 0, text='rdy', values=("", "Ready For Pick Up"))
        self.tree.insert(thisRow, 1, text="order",values=(order,""))
        self.currIndex += 1
