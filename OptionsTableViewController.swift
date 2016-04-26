//
//  OptionsTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/24/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    var menuItem: MenuItem!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = menuItem.name
        
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
            if menuItem.options.count == 0 { return 1 }
            return menuItem.options.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"

        if menuItem.options.count == 0 {
            cell.textLabel?.text = "No options. Press to continue to sides"
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = menuItem.options[indexPath.row].description
            cell.detailTextLabel?.text = menuItem.options[indexPath.row].price.asPriceString()
        }

        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sideMenu = segue.destinationViewController as? SidesTableViewController {
            let newMenuItem = MenuItem(otherMenuItem: menuItem)
            newMenuItem.options = [menuItem.options[Int((sender?.accessibilityIdentifier)!)!]]
            sideMenu.menuItem = newMenuItem
            
        }
    }
}
