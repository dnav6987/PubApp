//
//  TextViewController.swift
//  Professor
//
//  Created by Dan Navarro on 2/25/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class MenuItemViewController: UIViewController {
    var menuItem: MenuItem!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startOrderButton: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let tabCon = segue.destinationViewController as? UITabBarController {
            if let navCon = storyboard?.instantiateViewControllerWithIdentifier("OrderFlow") as? UINavigationController {
                if let optionMenu = navCon.visibleViewController as? OptionsTableViewController {
                    optionMenu.menuItem = MenuItem(otherMenuItem: menuItem)
                    tabCon.viewControllers?.insert(navCon, atIndex: 1)
                    navCon.tabBarItem.title = "Customize Order"
                    tabCon.selectedIndex = 1
                }
            }
        }
    }
    
    func setDescriptionLabel() {
        if startOrderButton != nil && menuItem != nil {
            var description = menuItem.name
            if menuItem.description.characters.count > 0 { description += "\n" + menuItem.description }
            for option in menuItem.options { description += "\n" + option.asString() }
            descriptionLabel.text = description
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if view != nil && presentingViewController != nil && menuItem != nil && startOrderButton != nil{
                setDescriptionLabel()
                let sizeThatFits = view.sizeThatFits(presentingViewController!.view.bounds.size)
                return CGSize(width: sizeThatFits.width,
                              height: startOrderButton.frame.height + descriptionLabel.heightOfLabel())
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}

private extension UILabel {
    func heightOfLabel() -> CGFloat {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = false
        return 1.5*label.frame.height // TODO
    }
}