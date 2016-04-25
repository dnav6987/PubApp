//
//  ToppingsTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class ToppingsTableViewController: UITableViewController {
    var menuItem: MenuItem!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuItemWithOutAddons = MenuItem(otherMenuItem: menuItem)
        menuItemWithOutAddons.addOns = [MenuOption]()
        descriptionLabel.text = menuItemWithOutAddons.asStringAndPrice().string
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuItem != nil { return menuItem.addOns.count }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingCell", forIndexPath: indexPath)
        
        cell.accessibilityIdentifier = "\(indexPath.row)"
        
        cell.textLabel?.text = menuItem.addOns[indexPath.row].description
        cell.detailTextLabel?.text = menuItem.addOns[indexPath.row].price.asPriceString()
        
        let offSwitch = UISwitch(frame: CGRectZero) as UISwitch
        offSwitch.on = false
        cell.accessoryView = offSwitch
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var selectedToppings = [MenuOption]()
        for cell in tableView.visibleCells {
            if let cellSwitch = cell.accessoryView as? UISwitch {
                print("\(Int(cell.accessibilityIdentifier!)!)")
                if cellSwitch.on {
                    selectedToppings.append(menuItem.addOns[Int(cell.accessibilityIdentifier!)!])
                }
            }
        }
        
        if var order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String] {
            order.append(menuItem.asStringAndPrice().string)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
        }
        
        if var prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float] {
            prices.append(menuItem.asStringAndPrice().price)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
        }
    }
}
