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

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    let menuItems = MenuItems() // the menu
    var menuItem: MenuItem! // the item being ordered
    var filteredMenu = [MenuItem]() // for filtered menu results
    
    // this allows the user to filter the menu
    var searchText: String = "" {
        didSet {
            searchTextField?.text = searchText
            filteredMenu = [MenuItem]() // clear the previous results
            
            if searchText != "" {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    for item in self.menuItems.items {
                        // the name contains the search string (case insensitive)
                        if item.name.lowercaseString.rangeOfString(self.searchText.lowercaseString) != nil {
                            self.filteredMenu.append(item)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
            } else {
                tableView.reloadData()
            }
        }
    }
    
    // the filter text field
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    // TODO necessary?
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text!
        }
        return true
    }
    // MARK: - Seuges

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    // info button pressed, display description popover
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        // instantiated this way because for some reason, dynamic cells cannot have a story board segue to a popover
        if let detailedMenuPopover = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailedMenuViewController") as? TextViewController {
            
            var menuItem = MenuItem()
            if filteredMenu.count > 0 {
                menuItem = filteredMenu[indexPath.row]
            } else {
                menuItem = menuItems.menu[indexPath.section][indexPath.row] // the selected menu item
            }
            
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
                if filteredMenu.count > 0 {
                    let indexPath = cell.accessibilityIdentifier!
                    optionMenu.menuItem = MenuItem(otherMenuItem: filteredMenu[Int(indexPath)!])
                } else {
                // section and row are separated by a space so separate them
                let indexPath = cell.accessibilityIdentifier!.characters.split{$0 == " "}.map(String.init)
                optionMenu.menuItem = MenuItem(otherMenuItem: menuItems.menu[Int(indexPath[0])!][Int(indexPath[1])!])
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if filteredMenu.count > 0 { return 1 }  // no need to separate filtered results
        return menuItems.menu.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredMenu.count > 0 { return filteredMenu.count } // display the filtered menu
        return menuItems.menu[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        
        if filteredMenu.count > 0 {
            cell.textLabel!.text = filteredMenu[indexPath.row].name    // title = item name
            cell.accessibilityIdentifier = "\(indexPath.row)"  // set its identifier to be it's index for parsing the data later
        } else {
        cell.textLabel!.text = menuItems.menu[indexPath.section][indexPath.row].name    // title = item name
        cell.accessibilityIdentifier = "\(indexPath.section) \(indexPath.row)"  // set its identifier to be it's index for parsing the data later
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if filteredMenu.count > 0 { return "Search Results" }
        if section < menuItems.menu.count { return menuItems.menu[section][0].type }  // They will all have the same type if in the same section
        return ""
    }
}