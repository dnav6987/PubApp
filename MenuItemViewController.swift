//
//  TextViewController.swift
//  Professor
//
//  Created by Dan Navarro on 2/25/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class MenuItemViewController: UIViewController {
    private struct Constants {
        static let BUTTON_HEIGHT = CGFloat(25)
    }
    
    var menuItem: MenuItem!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startOrderButton: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navCon = segue.destinationViewController as? UINavigationController {
            if let optionMenu = navCon.visibleViewController as? OptionsTableViewController {
                optionMenu.menuItem = menuItem
            }
        }
    }
    
    override func viewDidLoad() {        
        if menuItem != nil && view != nil  && startOrderButton != nil {
//            let label = UILabel(frame: CGRect(x: startOrderButton.frame.origin.x, y: startOrderButton.frame.height, width: startOrderButton.frame.width, height: 0))
//            label.text = "Add to order"
//            label.sizeToFit()
//            view.addSubview(label)
           //            var nextButtonHeight = descriptionLabel.heightOfLabel() + 1
//            var nextButtonHeight = topLayoutGuide.bottomAnchor.accessibilityActivationPoint.y
//            var identifier = 0
//            
//            for side in menuItem.addOns {
//                let button = makeButton(side.description+" $"+String(format: "%.2f", side.price),
//                                        height: nextButtonHeight,
//                                        identifier: identifier)
//                identifier += 1
//                nextButtonHeight += Constants.BUTTON_HEIGHT + 1
//            }
//            
//            identifier = 0
//            for option in menuItem.options  {
//                let button = makeButton(option.description+" $"+String(format: "%.2f", option.price),
//                                        height: nextButtonHeight,
//                                        identifier: identifier)
//                button.addTarget(self, action: #selector(MenuItemViewController.addToOrder(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//                identifier += 1
//                nextButtonHeight += Constants.BUTTON_HEIGHT + 1
//            }
        }
    }

    func makeButton(title: String, height: CGFloat, identifier: Int) -> UIButton {
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.setTitle(title, forState: .Normal)
        button.sizeToFit()
        let origin = CGPoint(x: view.frame.width/2 - button.frame.width/2, y: height)
        button.frame = CGRect(origin: origin, size: CGSize(width: button.frame.width, height: Constants.BUTTON_HEIGHT))
        view.addSubview(button)
        button.accessibilityIdentifier = "\(identifier)"
        return button
    }
    
    func addToOrder(sender:UIButton!) {
        if sender.currentTitle != nil {
            let chosenOption = menuItem.options[Int(sender.accessibilityIdentifier!)!]
            let orderedItem = menuItem.name + ", " + chosenOption.description
            var order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String]
            var prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float]
            if order != nil && prices != nil {
                order!.append(orderedItem)
                Order.defaults.setObject(order!, forKey: Order.ORDER_STRING)
                prices!.append(chosenOption.price)
                Order.defaults.setObject(prices!, forKey: Order.PRICES_STRING)
//                Order.defaults.synchronize()
            } else {
                Order.defaults.setObject([orderedItem], forKey: Order.ORDER_STRING)
                Order.defaults.setObject([chosenOption.price], forKey: Order.PRICES_STRING)
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