//
//  OrderTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit
import Foundation

class OrderTableViewController: UITableViewController {
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
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
        let connection = NetworkConnection()
        connection.connect("127.0.0.1", port: 5555)
        if connection.outputStream != nil {
            var orderDataString = "[ \n\n"
            for item in order { orderDataString += item + "\n\n"}
            orderDataString += "price: \(totalPrice)\n\nfrom user: DNAV\n\n]"
            connection.outputStream!.write(orderDataString, maxLength: orderDataString.characters.count)
            
            if connection.status != NetworkConnection.StatusConstants.SEND {
                couldNotSendAlert()
            } else {
                clearCart(UIButton())
            }
        } else {
            couldNotSendAlert()
        }
        
        connection.close()
    }
    
    func couldNotSendAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "Oops! The server could not be reached. Try submitting your order at a later time or just call it in at\n(207) 725-3888", preferredStyle: UIAlertControllerStyle.Alert)
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
