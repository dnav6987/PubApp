//
//  MenuTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/18/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    A static (for now) menu. When food items are pressed they will segue to a Popover with a detailed description and button to order
 */

import UIKit

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var menuItems = MenuItems() // Essentially a dictionary holding the menu

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let menuItem = menuItems.items[identifier] { // make sure it is a valid menu item
                if let mivc = segue.destinationViewController as? MenuItemViewController {
                    mivc.menuItem = menuItem    // set its menuItem
                    if let ppc = mivc.popoverPresentationController { ppc.delegate = self }
                }
            }
        }
    }
    
    // don't preform segues on items not in the menu (not that this should happen)
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if let _ = menuItems.items[identifier] { return true }
        return false
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
