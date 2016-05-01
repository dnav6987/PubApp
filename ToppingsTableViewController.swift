//
//  ToppingsTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    Display the add ons and toppings that can be put on this order. Display them with a switch because they can either be added on or not.
 */

import UIKit

class ToppingsTableViewController: UITableViewController {
    var menuItem: MenuItem! // the item being ordered
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the item being orderd
        
        // don't yet know what toppings are wanted to don't display them
        let menuItemWithOutAddons = MenuItem(otherMenuItem: menuItem)
        menuItemWithOutAddons.addOns = [MenuOption]()
        
        descriptionLabel.text = menuItemWithOutAddons.asStringAndPrice().string + "\n" + menuItemWithOutAddons.asStringAndPrice().price.asPriceString()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuItem != nil {
            if menuItem.addOns.count == 0 { return 1 }  // if there are none, still want one cell for instructions to move on
            return menuItem.addOns.count }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToppingCell", forIndexPath: indexPath)
        
        cell.accessibilityIdentifier = "\(indexPath.row)"   // set its identifier to be it's index for parsing the data later
        
        // if there are none we want to give an instruction to just move on.
        if menuItem.addOns.count == 0 {
            cell.textLabel?.text = "No toppings options. Continue to cart"
            cell.detailTextLabel?.text = ""
        } else {
            // title = name, subtitle = price
            cell.textLabel?.text = menuItem.addOns[indexPath.row].description
            cell.detailTextLabel?.text = menuItem.addOns[indexPath.row].price.asPriceString()
        
            // add a switch so toppings can be easily added
            let offSwitch = UISwitch(frame: CGRectZero) as UISwitch
            offSwitch.on = false
            cell.accessoryView = offSwitch
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var selectedToppings = [MenuOption]()
        
        // get all the toppings that were selected
        for cell in tableView.visibleCells {
            if let cellSwitch = cell.accessoryView as? UISwitch {
                if cellSwitch.on {
                    selectedToppings.append(menuItem.addOns[Int(cell.accessibilityIdentifier!)!])
                }
            }
        }
        
        // the menu item with the selected toppings only
        let newMenuItem = MenuItem(otherMenuItem: menuItem)
        newMenuItem.addOns = selectedToppings
        
        // set the order and the prices
        
        if var order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String] {
            order.append(newMenuItem.asStringAndPrice().string)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
        }
        
        if var prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float] {
            prices.append(newMenuItem.asStringAndPrice().price)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
        }
        
        // segue to the order page, which has tab index 1
        if let tabCon = segue.destinationViewController as? UITabBarController {
            tabCon.selectedIndex = 1
        }
    }
}
