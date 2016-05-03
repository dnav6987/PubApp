//
//  OrderTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    This is where the user's order is displayed in a table. The order can be placed and alerts tell the user the status of the order.
 */

// TODO check that they are on bowoin wifi

import UIKit
import Foundation

// MARK: - Alert Message constants

// Messages to notify the user
struct AlertMessages {
    static let SERVER_ERROR = "Oops! The server could not be reached. Try submitting your order at a later time or just call it in at\n(207) 725-3888"
    static let EMPTY_CART = "Oops! Cannot place an empty order."
    static let RCVD = "Your order has been recieved! Thank you for ordering from Jack Magee's Pub."
    static let RDY = "Your order is ready for pick up. Enjoy your meal."
}

// MARK: - Order Table View Controller

class OrderTableViewController: UITableViewController, NetworkConnectionDelegate {
    var order: [String]!    // the items being ordered
    var prices: [Float]!    // the prices of the items
    
    @IBOutlet weak var priceLabel: UILabel! // display the total price
    
    var totalPrice: Float = 0.0 {   // the total price
        didSet {
            if priceLabel != nil { priceLabel.text = "Total Price $" + String(format: "%.2f", totalPrice) }
        }
    }
    
    // MARK: - User Control Buttons
    
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
    
    var connection = NetworkConnection()    // Connection to server
    
    // MARK: - Initializations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection.delegate = self  //  need this view controller to be notified when data is recieved
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()   // refresh the data
        connection.connect("127.0.0.1", port: 5555) // connect to the server (may be redundant but it is a good chance to try to reconnect if it was previously down)
    }
    
    override func viewWillDisappear(animated: Bool) {
        connection.inputStream!.close()
        connection.outputStream!.close()
    }
    
    // get the order data and reset the view
    func refresh() {
        // set the user control buttons
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
        
        // get the current order and prices
        order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String]
        prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float]
        
        // initialize order and prices if they have not yet been set
        if order == nil {   // NOTE that if order is nil prices must be too
            order = [String]()
            prices = [Float]()
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
        }
        
        totalPrice = prices.reduce(0, combine: +) // Sum of the prices list
        
        tableView.reloadData()
    }
    
    // MARK: - User controls
    
    // give user the option to confirm their order or cancel it
    func placeOrder(sender:UIButton!) {
        navigationItem.leftBarButtonItem = confirmButton
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    // just reset the user control buttons
    func cancelOrder(sender:UIButton!) {
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
    }
    
    // empty the cart
    @IBAction func clearCart(sender: UIButton) {
        Order.defaults.setObject([String](), forKey: Order.ORDER_STRING)
        Order.defaults.setObject([Float](), forKey: Order.PRICES_STRING)
        refresh()
    }
    
    // MARK: - Server interaction (the meat of this file)
    
    /* 
        This is where the application interacts with the server and other interesting stuff happens.
     
        Flow of events:
            1) Make sure there is an order to send
            2) Get the name and i.d. of the user (any pub enthusiast will recognize this from ordering over the phone)
            3) Connect to server
            4) Send order to server
            5) Wait for confirmation from server
     
        If at any point an error occurs the user will be updated with an alert message
    */
    func confirmOrder(sender:UIButton!) {
        if order.count != 0 {   // make sure there is actually an order
            // text fields for the user to enter their information
            var nameTextField: UITextField?
            var idTextField: UITextField?
            
            // prompt the user for their name and i.d.
            let alertController = UIAlertController(title: "Personal Information", message: "Please enter your name and Bowdoin I.D. Number", preferredStyle: .Alert)
            
            // submit button: remember the user's information for next time and send order to server
            let submit = UIAlertAction(title: "Submit", style: .Default, handler: { (action) -> Void in
                Order.defaults.setObject(nameTextField?.text, forKey: Order.NAME)
                Order.defaults.setObject(idTextField?.text, forKey: Order.ID)
                
                self.updateFavorites()
                
                self.sendOrderToServer()
            })
            
            // cancel button
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            // add the buttons
            alertController.addAction(submit)
            alertController.addAction(cancel)
            
            // add the text fields
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                nameTextField = textField
                nameTextField?.placeholder = "Name"
                // use the name they have previously provided
                if let name = Order.defaults.objectForKey(Order.NAME) as? String { nameTextField?.text = name }
            }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                idTextField = textField
                idTextField?.placeholder = "I.D."
                // use the i.d. they have previously provided
                if let id = Order.defaults.objectForKey(Order.ID) as? String { idTextField?.text = id }
            }
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            alert("Error", message: AlertMessages.EMPTY_CART)
        }
    }
    
    // this is where the actual server connections happen
    func sendOrderToServer() {
        if connection.outputStream != nil && connection.inputStream != nil {
            // the connection may be slow so present an activity view controller so the user isn't left confused (we won't wait forever though!)
            let activityViewController = ActivityViewController(message: "Connecting...")
            presentViewController(activityViewController, animated: true, completion: nil)
            
            connection.outputStream!.open() // open the output connection to the server
            
            // order items seperated by two lines and then add on price and user information. This makes it easy to parse at the server
            var orderDataString = "[ \n\n"
            for item in order { orderDataString += item + "\n\n"}
            orderDataString += "Price: \(totalPrice.asPriceString())\n\n"
            orderDataString += "Name: \(Order.defaults.objectForKey(Order.NAME) as! String)\n\n"
            orderDataString += "Bowdoin I.D.: \(Order.defaults.objectForKey(Order.ID) as! String)\n\n]"
            
            // send the data and then close the connection, it only needs to write once
            connection.outputStream!.write(orderDataString, maxLength: orderDataString.characters.count)
            connection.outputStream!.close()
        
            // wait for response from server, this could take a while so do in another thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let start = NSDate()    // time at which the connection started (too track wait time)
                
                while true {    // I know, I know, this is dangerous... but living on the edge (and a gauruntee that a timer will break out of the loop)
                    if self.connection.inputStream!.hasBytesAvailable {
                        // Wait for confirmation that the server recieved the order. If timer runsout, assume the data was lost
                        
                        // see if the server has sent data back (server only sends three chars)
                        var buffer = [UInt8](count: ServerResponses.RESPONSE_CODE_LENGTH, repeatedValue: 0)
                        self.connection.inputStream!.read(&buffer, maxLength: buffer.count)
                        
                        // when the data recieves an order it should send back a "rcv". If so, stop the activity view and display a success alert
                        if String(bytes: buffer, encoding: NSUTF8StringEncoding) == ServerResponses.RECIEVED_ORDER {
                            dispatch_async(dispatch_get_main_queue()) {
                                activityViewController.dismissViewControllerAnimated(false, completion: { () -> Void in
                                    self.alert("Success", message: AlertMessages.RCVD)
                                })
                                self.clearCart(UIButton())   // empty the cart, it has already been ordered
                            }
                            break
                        }
                    }
                    
                    else if NSDate().timeIntervalSinceDate(start) >= 8 { // if this amount of time (in seconds) is exceeded, report and error
                        dispatch_async(dispatch_get_main_queue()) {
                            activityViewController.dismissViewControllerAnimated(false, completion: { () -> Void in
                                self.alert("Error", message: AlertMessages.SERVER_ERROR)
                            })
                        }
                        break
                    }
                }
            }
        } else {
            alert("Error", message: AlertMessages.SERVER_ERROR)
        }
    }
    
    // MARK: - alerts
    
    // Display and alert view
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))  // button to dismiss the alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - favorites
    
    // Update the favorites counts.
    func updateFavorites() {
        if Order.defaults.objectForKey(Order.FAVORITES_COUNTS) == nil {
            Order.defaults.setObject([String: Int](), forKey: Order.FAVORITES_COUNTS)
            Order.defaults.setObject([String: Float](), forKey: Order.FAVORITES_PRICES)
        }
        
        var favoritesCounts = Order.defaults.objectForKey(Order.FAVORITES_COUNTS) as! [String: Int]
        var favoritesPrices = Order.defaults.objectForKey(Order.FAVORITES_PRICES) as! [String: Float]
        
        for itemIndex in 0..<order.count {
            if let thisItemCount = favoritesCounts[order[itemIndex]] {
                favoritesCounts[order[itemIndex]] = thisItemCount + 1
            } else {
                favoritesCounts[order[itemIndex]] = 1
                favoritesPrices[order[itemIndex]] = prices[itemIndex]
            }
        }
        
        Order.defaults.setObject(favoritesCounts, forKey: Order.FAVORITES_COUNTS)
        Order.defaults.setObject(favoritesPrices, forKey: Order.FAVORITES_PRICES)
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if order != nil && section == 0 { return order.count }
        return 0
    }
    
    // set each cell. title = the item's name, subtitle = the price
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath)
        if order != nil {
            cell.textLabel?.text = order[indexPath.row]
            cell.detailTextLabel?.text = prices[indexPath.row].asPriceString()
        }
        return cell
    }
    
    // deleting items from the order (because we all make mistakes)
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // update the data source
            order.removeAtIndex(indexPath.row)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
            prices.removeAtIndex(indexPath.row)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
            
            // delete the cell
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            refresh()
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
