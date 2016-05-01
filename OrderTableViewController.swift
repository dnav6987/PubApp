//
//  OrderTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit
import Foundation

struct AlertMessages {
    static let SERVER_ERROR = "Oops! The server could not be reached. Try submitting your order at a later time or just call it in at\n(207) 725-3888"
    static let EMPTY_CART = "Oops! Cannot place an empty order."
    static let RCVD = "Your order has been recieved! Thank you for ordering from Jack Magee's Pub."
    static let RDY = "Your order is ready for pick up. Enjoy your meal."
}

class OrderTableViewController: UITableViewController, NetworkConnectionDelegate {
    var order: [String]!
    var prices: [Float]!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var totalPrice: Float = 0.0 {
        didSet {
            if priceLabel != nil { priceLabel.text = "Total Price $" + String(format: "%.2f", totalPrice) }
        }
    }
    
    lazy var orderButton: UIBarButtonItem! = {
        return UIBarButtonItem(title: "Place Order",
                               style: .Plain,
                               target: self,
                               action: #selector(OrderTableViewController.placeOrder(_:)))
    }()
    
    lazy var confirmButton: UIBarButtonItem! = {
        return UIBarButtonItem(title: "Confirm",
                               style: .Plain,
                               target: self,
                               action: #selector(OrderTableViewController.confirmOrder(_:)))
    }()
    
    lazy var cancelButton: UIBarButtonItem! = {
        return UIBarButtonItem(barButtonSystemItem: .Cancel,
                               target: self,
                               action: #selector(OrderTableViewController.cancelOrder(_:)))
    }()
    
    var connection = NetworkConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        connection.connect("127.0.0.1", port: 5555)
    }
    
    func refresh() {
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
        
        order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String]
        prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float]
        if order == nil {   // NOTE that if one is nil the other must be too
            order = [String]()
            prices = [Float]()
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
        }
        
        totalPrice = prices.reduce(0, combine: +) // Sum of the list
        tableView.reloadData()
    }
    
    func placeOrder(sender:UIButton!) {
        navigationItem.leftBarButtonItem = confirmButton
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    func confirmOrder(sender:UIButton!) {
        if order.count != 0 {
            var nameTextField: UITextField?
            var idTextField: UITextField?
            
            let alertController = UIAlertController(title: "Personal Information", message: "Please enter your name and Bowdoin I.D. Number", preferredStyle: .Alert)
            
            let submit = UIAlertAction(title: "Submit", style: .Default, handler: { (action) -> Void in
                Order.defaults.setObject(nameTextField?.text, forKey: Order.NAME)
                Order.defaults.setObject(idTextField?.text, forKey: Order.ID)
                self.sendOrderToServer()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alertController.addAction(submit)
            alertController.addAction(cancel)
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                nameTextField = textField
                nameTextField?.placeholder = "Name"
                
                if let name = Order.defaults.objectForKey(Order.NAME) as? String { nameTextField?.text = name }
            }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                idTextField = textField
                idTextField?.placeholder = "I.D."
                
                if let id = Order.defaults.objectForKey(Order.ID) as? String { idTextField?.text = id }
            }
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            alert("Error", message: AlertMessages.EMPTY_CART)
        }
    }
    
    func sendOrderToServer() {
        if connection.outputStream != nil && connection.inputStream != nil {
            connection.outputStream!.open()
            
            var orderDataString = "[ \n\n"
            for item in order { orderDataString += item + "\n\n"}
            orderDataString += "price: \(totalPrice)\n\nfrom user: DNAV\n\n]"
            
            connection.outputStream!.write(orderDataString, maxLength: orderDataString.characters.count)
            connection.outputStream!.close()
            
            let activitiyViewController = ActivityViewController(message: "Connecting...")
            presentViewController(activitiyViewController, animated: true, completion: nil)
            
            let start = NSDate()
            
            while true {
                if connection.inputStream!.hasBytesAvailable {
                    var buffer = [UInt8](count: 3, repeatedValue: 0)
                    connection.inputStream!.read(&buffer, maxLength: buffer.count)
                    
                    if String(bytes: buffer, encoding: NSUTF8StringEncoding) == "rcv" {
                        activitiyViewController.dismissViewControllerAnimated(false, completion: { () -> Void in
                            self.alert("Success", message: AlertMessages.RCVD)
                        })
                        clearCart(UIButton())
                        break
                    }
                }
                
                if NSDate().timeIntervalSinceDate(start) >= 3 {
                    activitiyViewController.dismissViewControllerAnimated(false, completion: { () -> Void in
                        self.alert("Error", message: AlertMessages.SERVER_ERROR)
                    })
                    break
                }
            }
        } else {
            alert("Error", message: AlertMessages.SERVER_ERROR)
        }
    }
    
    func getUserInfo() {
        let activitiyViewController = ActivityViewController(message: "Connecting...")
        presentViewController(activitiyViewController, animated: true, completion: nil)
        
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func cancelOrder(sender:UIButton!) {
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
    }
    
    @IBAction func clearCart(sender: UIButton) {
        Order.defaults.setObject([String](), forKey: Order.ORDER_STRING)
        Order.defaults.setObject([Float](), forKey: Order.PRICES_STRING)
        refresh()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if order != nil && section == 0 { return order.count }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath)
        if order != nil {
            cell.textLabel?.text = order[indexPath.row]
            cell.detailTextLabel?.text = prices[indexPath.row].asPriceString()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            order.removeAtIndex(indexPath.row)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
            prices.removeAtIndex(indexPath.row)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            refresh()
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
