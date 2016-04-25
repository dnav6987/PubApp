//
//  SidesTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class SidesTableViewController: UITableViewController {
    var menuItem: MenuItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if menuItem.sides.count <= 1 {
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                let fakeSender = UIButton()
                fakeSender.accessibilityIdentifier = "-1"
                self.performSegueWithIdentifier("ToToppings", sender: fakeSender)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuItem != nil { return menuItem.sides.count }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"
        
        cell.textLabel?.text = menuItem.sides[indexPath.row].description
        cell.detailTextLabel?.text = menuItem.sides[indexPath.row].price.asPriceString()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let toppingMenu = segue.destinationViewController as? ToppingsTableViewController {
            if menuItem.sides.count > 1 {
                menuItem.sides = [menuItem.sides[Int((sender?.accessibilityIdentifier)!)!]]
            }
            toppingMenu.menuItem = menuItem
        }
    }
}
