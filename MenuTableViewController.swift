//
//  MenuTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 4/18/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var menuItems = MenuItems()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let menuItem = menuItems.items[identifier] {
                if let tvc = segue.destinationViewController as? MenuItemViewController {
                    tvc.menuItem = menuItem
                    if let ppc = tvc.popoverPresentationController { ppc.delegate = self }
                }
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
