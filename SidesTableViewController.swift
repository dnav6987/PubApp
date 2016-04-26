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

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuItemWithOutSidesOrAddons = MenuItem(otherMenuItem: menuItem)
        menuItemWithOutSidesOrAddons.sides = [MenuOption]()
        menuItemWithOutSidesOrAddons.addOns = [MenuOption]()
        let menuItemDescription = menuItemWithOutSidesOrAddons.asStringAndPrice()
        descriptionLabel.text = menuItemDescription.string + "\n" + menuItemDescription.price.asPriceString()
        
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
        if menuItem != nil {
            if menuItem.sides.count == 0 { return 1 }
            return menuItem.sides.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"
        
        if menuItem.sides.count == 0 {
            cell.textLabel?.text = "No side options. Press to continue to sides"
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = menuItem.sides[indexPath.row].description
            cell.detailTextLabel?.text = menuItem.sides[indexPath.row].price.asPriceString()
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let toppingMenu = segue.destinationViewController as? ToppingsTableViewController {
            let newMenuItem = MenuItem(otherMenuItem: menuItem)
            if newMenuItem.sides.count > 1 {
                newMenuItem.sides = [newMenuItem.sides[Int((sender?.accessibilityIdentifier)!)!]]
            }
            toppingMenu.menuItem = newMenuItem
        }
    }
}
