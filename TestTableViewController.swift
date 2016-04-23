//
//  TestTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/23/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    let menuItems = MenuItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
