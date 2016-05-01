//
//  SidesTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    Display the sides that can be put on this order.
*/

import UIKit

class SidesTableViewController: UITableViewController {
    var menuItem: MenuItem! // the item being ordered

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the item being orderd
        
        // don't yet know what side or toppings are wanted to don't display them
        let menuItemWithOutSidesOrAddons = MenuItem(otherMenuItem: menuItem)
        menuItemWithOutSidesOrAddons.sides = [MenuOption]()
        menuItemWithOutSidesOrAddons.addOns = [MenuOption]()
        let menuItemDescription = menuItemWithOutSidesOrAddons.asStringAndPrice()
        descriptionLabel.text = menuItemDescription.string + "\n" + menuItemDescription.price.asPriceString()
        
        // if there aren't choices for them to make, automatically segue to the next step
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
            if menuItem.sides.count == 0 { return 1 }   // if there are none, still want one cell for instructions to move on
            return menuItem.sides.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"   // set its identifier to be it's index for parsing the data later
        
        // if there are none we want to give an instruction to just move on.
        if menuItem.sides.count == 0 {
            cell.textLabel?.text = "No side options. Press to continue to sides"
            cell.detailTextLabel?.text = ""
        } else {
            // title = name, subtitle = price
            cell.textLabel?.text = menuItem.sides[indexPath.row].description
            cell.detailTextLabel?.text = menuItem.sides[indexPath.row].price.asPriceString()
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let toppingMenu = segue.destinationViewController as? ToppingsTableViewController {
            let newMenuItem = MenuItem(otherMenuItem: menuItem) // so we don't modify this view's menuItem
            if newMenuItem.sides.count > 1 {
                // get the side using the view cell's identifier that was set above
                newMenuItem.sides = [newMenuItem.sides[Int((sender?.accessibilityIdentifier)!)!]]
            }
            toppingMenu.menuItem = newMenuItem
        }
    }
}
