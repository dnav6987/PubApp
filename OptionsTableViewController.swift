//
//  OptionsTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    var menuItem: MenuItem! // the item being ordered

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the name of the item being ordered
        descriptionLabel.text = menuItem.name
        
        // if there aren't choices for them to make, automatically segue to the next step
        if menuItem.options.count <= 1 {
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                let fakeSender = UIButton()
                fakeSender.accessibilityIdentifier = "0"
                self.performSegueWithIdentifier("ToSides", sender: fakeSender)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuItem != nil {
            if menuItem.options.count == 0 { return 1 } // if there are none, still want one cell for instructions to move on
            return menuItem.options.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"   // set its identifier to be it's index for parsing the data later

        // if there are none we want to give an instruction to just move on.
        if menuItem.options.count == 0 {
            cell.textLabel?.text = "No options. Press to continue to sides"
            cell.detailTextLabel?.text = ""
        } else {
            // title = name, subtitle = price
            cell.textLabel?.text = menuItem.options[indexPath.row].description
            cell.detailTextLabel?.text = menuItem.options[indexPath.row].price.asPriceString()
        }

        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sideMenu = segue.destinationViewController as? SidesTableViewController {
            let newMenuItem = MenuItem(otherMenuItem: menuItem) // so we don't modify this view's menuItem
            // get the side using the view cell's identifier that was set above
            newMenuItem.options = [menuItem.options[Int((sender?.accessibilityIdentifier)!)!]]
            sideMenu.menuItem = newMenuItem
        }
    }
}
