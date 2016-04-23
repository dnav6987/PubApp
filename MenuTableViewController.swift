//
//  TestTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/23/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    let menuItems = MenuItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Seuges

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let detailedMenuPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailedMenuViewController") as? MenuItemViewController {
            detailedMenuPopover.menuItem = menuItems.menu[indexPath.section][indexPath.row]
            detailedMenuPopover.modalPresentationStyle = .Popover
            
            if let ppc = detailedMenuPopover.popoverPresentationController {
                ppc.delegate = self
                ppc.permittedArrowDirections = [.Up, .Down]
                ppc.sourceView = tableView.cellForRowAtIndexPath(indexPath)?.contentView
                presentViewController(detailedMenuPopover, animated: false, completion: nil)
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

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section < menuItems.menu.count { return menuItems.menu[section][0].type }  // They will all have the same type
        return ""
    }
}

extension Array where Element:MenuItem {
    func itemForName(itemName: String) -> MenuItem! {
        for item in self {
            if item.name == itemName { return item }
        }
        return nil
    }
}