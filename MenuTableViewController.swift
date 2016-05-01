//
//  MenuTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/23/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    Table to display the menu
*/

import UIKit

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    let menuItems = MenuItems() // the menu
    var menuItem: MenuItem! // the item being ordered

    // MARK: - Seuges

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    // info button pressed, display description popover
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        // instantiated this way because for some reason, dynamic cells cannot have a story board segue to a popover
        if let detailedMenuPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailedMenuViewController") as? TextViewController {
            let menuItem = menuItems.menu[indexPath.section][indexPath.row] // the selected menu item
            
            // display the item description and options
            var description = menuItem.description + (menuItem.description != "" ? "\n": "")
            for option in menuItem.options { description += option.asString() + "\n" }
            // remove the trailing end line
            description.removeAtIndex(description.characters.endIndex.predecessor())
            
            detailedMenuPopover.text = description
            detailedMenuPopover.modalPresentationStyle = .Popover
            
            if let ppc = detailedMenuPopover.popoverPresentationController {
                ppc.delegate = self
                ppc.permittedArrowDirections = [.Up, .Down]
                ppc.sourceView = tableView.cellForRowAtIndexPath(indexPath)?.contentView
                presentViewController(detailedMenuPopover, animated: true, completion: nil)
            }
        }
    }
    
    // a menu item was selected. segue to the ordering flow
    // flow = Pick option -> Pick side -> Pick toppings -> Add to cart -> Order
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let optionMenu = segue.destinationViewController as? OptionsTableViewController {
            if let cell = sender as? UITableViewCell {
                // section and row are separated by a space so separate them
                let indexPath = cell.accessibilityIdentifier!.characters.split{$0 == " "}.map(String.init)
                optionMenu.menuItem = MenuItem(otherMenuItem: menuItems.menu[Int(indexPath[0])!][Int(indexPath[1])!])
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuItems.menu.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.menu[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        cell.textLabel!.text = menuItems.menu[indexPath.section][indexPath.row].name    // title = item name
        cell.accessibilityIdentifier = "\(indexPath.section) \(indexPath.row)"  // set its identifier to be it's index for parsing the data later
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section < menuItems.menu.count { return menuItems.menu[section][0].type }  // They will all have the same type if in the same section
        return ""
    }
}