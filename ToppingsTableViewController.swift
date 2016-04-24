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

    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
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
        
        let topping = menuItem.addOns[indexPath.row].asString().characters.split{$0 == "$"}.map(String.init)
        if topping.count == 1 {
            cell.textLabel?.text = MenuItems.Options.NO_OPTIONS
            cell.detailTextLabel?.text = topping[0]
        } else {
            cell.textLabel?.text = topping[0]
            cell.detailTextLabel?.text = topping[1]
        }
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let navCon = segue.destinationViewController as? UINavigationController {
//            if let toppingMenu = navCon.visibleViewController as? ToppingsTableViewController {
//                menuItem.sides = [menuItem.sides[Int((sender?.accessibilityIdentifier)!)!]]
//                toppingMenu.menuItem = menuItem
//            }
//        }
//    }
}
