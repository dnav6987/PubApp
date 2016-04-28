from Tkinter import Tk, Button, Label, OptionMenu, StringVar
from ttk import Treeview

class ResponseCodes:
    RCV = "rcv"
    RDY = "rdy"
    ERR_ID = "eid"
    ERR = "err"

    @staticmethod
    def codes():
        return [ResponseCodes.RCV, ResponseCodes.RDY, ResponseCodes.ERR_ID, ResponseCodes.ERR]

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
        customer_id = self.tree.item(self.tree.parent(item),"text")

        for code in ResponseCodes.codes():
            if response == code:
                self.controller.send_msg(customer_id, response)
                break

    def takeOrder(self, customer_id, order):
        thisRow = str(self.currIndex)
        self.tree.insert("", self.currIndex, thisRow, text=customer_id)
        self.tree.insert(thisRow, 0, text=ResponseCodes.RDY, values=("", "Ready For Pick Up"))
        self.tree.insert(thisRow, 1, text=ResponseCodes.ERR_ID, values=("", "Invalid ID"))
        self.tree.insert(thisRow, 2, text=ResponseCodes.ERR, values=("", "Miscellanious Error"))
        self.tree.insert(thisRow, 3, text="order",values=(order,""))
        self.currIndex += 1
