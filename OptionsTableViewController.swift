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
        
        let option = menuItem.options[indexPath.row].asString().characters.split{$0 == "$"}.map(String.init)
        if option.count == 1 {
            cell.textLabel?.text = MenuItems.Options.NO_OPTIONS
            cell.detailTextLabel?.text = option[0]
        } else {
            cell.textLabel?.text = option[0]
            cell.detailTextLabel?.text = option[1]
        }

        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navCon = segue.destinationViewController as? UINavigationController {
            if let sideMenu = navCon.visibleViewController as? SidesTableViewController {
                sideMenu.menuItem = MenuItem(name: menuItem.name,
                                             description: menuItem.description,
                                             options: [menuItem.options[Int((sender?.accessibilityIdentifier)!)!]],
                                             type: menuItem.type)
            }
        }
    }
}
