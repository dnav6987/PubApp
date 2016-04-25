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
    
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if menuItem.options.count == 1 {
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
        if menuItem != nil { return menuItem.options.count }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"

        cell.textLabel?.text = menuItem.options[indexPath.row].description
        cell.detailTextLabel?.text = menuItem.options[indexPath.row].price.asPriceString()

        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sideMenu = segue.destinationViewController as? SidesTableViewController {
            menuItem.options = [menuItem.options[Int((sender?.accessibilityIdentifier)!)!]]
            sideMenu.menuItem = menuItem
            
        }
    }
}
