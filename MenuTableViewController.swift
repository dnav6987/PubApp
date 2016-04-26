//
//  MenuTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/23/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    let menuItems = MenuItems()
    var menuItem: MenuItem!

    // MARK: - Seuges

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if let detailedMenuPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailedMenuViewController") as? TextViewController {
            let menuItem = menuItems.menu[indexPath.section][indexPath.row]
            var description = menuItem.name
            if menuItem.description != "" { description += "\n" + menuItem.description }
            for option in menuItem.options { description += "\n" + option.asString() }
            
            detailedMenuPopover.text = description
            detailedMenuPopover.modalPresentationStyle = .Popover
            
            if let ppc = detailedMenuPopover.popoverPresentationController {
                ppc.delegate = self
                ppc.permittedArrowDirections = [.Up, .Down]
                ppc.sourceView = tableView.cellForRowAtIndexPath(indexPath)?.contentView
                presentViewController(detailedMenuPopover, animated: false, completion: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let optionMenu = segue.destinationViewController as? OptionsTableViewController {
            if let cell = sender as? UITableViewCell {
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
        cell.textLabel!.text = menuItems.menu[indexPath.section][indexPath.row].name
        cell.accessibilityIdentifier = "\(indexPath.section) \(indexPath.row)"
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section < menuItems.menu.count { return menuItems.menu[section][0].type }  // They will all have the same type
        return ""
    }
}