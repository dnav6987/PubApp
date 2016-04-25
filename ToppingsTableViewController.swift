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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let navCon = segue.destinationViewController as? UINavigationController {
//            if let toppingMenu = navCon.visibleViewController as? ToppingsTableViewController {
//                menuItem.sides = [menuItem.sides[Int((sender?.accessibilityIdentifier)!)!]]
//                toppingMenu.menuItem = menuItem
//            }
//        }
//    }
}
