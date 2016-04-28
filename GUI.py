from Tkinter import Tk, Button, Label, OptionMenu, StringVar
from tkFont import Font
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
    def __init__(self):
        self.currIndex = 0

        # initialize the GUI
        self.app = Tk()
        self.app.title('Tic Tac Toe')
        self.font = Font(family="Courier", size=16)

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

        for code in ResponseCodes.codes():
            if response == code:
                print "sending:", code
                break

    def takeOrder(self, order):
        thisRow = str(self.currIndex)
        self.tree.insert("", self.currIndex, thisRow, text="B6151")
        self.tree.insert(thisRow, 0, text=ResponseCodes.RDY, values=("", "Ready For Pick Up"))
        self.tree.insert(thisRow, 1, text=ResponseCodes.ERR_ID, values=("", "Invalid ID"))
        self.tree.insert(thisRow, 2, text=ResponseCodes.ERR, values=("", "Miscellanious Error"))
        self.tree.insert(thisRow, 3, text="order",values=(order,""))
        self.currIndex += 1
