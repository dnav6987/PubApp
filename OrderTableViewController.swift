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
        // HUGE TODO
        
        let addr = "127.0.0.1"
        let port = 5555
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let outputStream = out!
        outputStream.open()

        var orderDataString = "[ "
        for item in order { orderDataString += item + " "}
        orderDataString += "]"
        outputStream.write(orderDataString, maxLength: orderDataString.characters.count)
        
        clearCart(UIButton())
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
