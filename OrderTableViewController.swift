//
//  OrderTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var order: [String]!
    
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
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
        order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String]
        tableView.reloadData()
    }
    
    func placeOrder(sender:UIButton!) { navigationItem.rightBarButtonItem = cancelButton }
    
    func confirmOrder(sender:UIButton!) {
        // HUGE TODO
    }
    
    func cancelOrder(sender:UIButton!) {
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem = orderButton
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if order != nil && order.count > 0 { return 1 }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if order != nil && section == 0 { return order.count }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath) as! OrderTableViewCell
        if order != nil { cell.order = order[indexPath.row] }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            order.removeAtIndex(indexPath.row)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    

}
