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
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet { if menuItem != nil { descriptionLabel.text = menuItem.description } }
    }
    
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        if menuItem != nil && view != nil {
            
            var nextButtonHeight = descriptionLabel.heightOfLabel() + 1
            
            var identifier = 0
            for option in menuItem.options  {
                let button = UIButton(type: UIButtonType.System) as UIButton
                button.addTarget(self, action: #selector(MenuItemViewController.addToOrder(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                button.setTitle(option.description+" $"+String(format: "%.2f", option.price), forState: .Normal)
                button.sizeToFit()
                let origin = CGPoint(x: view.frame.width/2 - button.frame.width/2, y: nextButtonHeight)
                button.frame = CGRect(origin: origin, size: CGSize(width: button.frame.width, height: Constants.BUTTON_HEIGHT))
                view.addSubview(button)
                button.accessibilityIdentifier = "\(identifier)"
                identifier += 1
                nextButtonHeight += Constants.BUTTON_HEIGHT + 1
            }
        }
    }

    override var preferredContentSize: CGSize {
        get {
            if view != nil && presentingViewController != nil && menuItem != nil && descriptionLabel != nil {
                let sizeThatFits = view.sizeThatFits(presentingViewController!.view.bounds.size)
                return CGSize(width: sizeThatFits.width,
                              height: CGFloat(menuItem.options.count)*Constants.BUTTON_HEIGHT +
                                CGFloat(menuItem.options.count) + descriptionLabel.heightOfLabel())
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
    
    func addToOrder(sender:UIButton!) {
        if sender.currentTitle != nil {
            let chosenOption = menuItem.options[Int(sender.accessibilityIdentifier!)!]
            let orderedItem = menuItem.description + ", " + chosenOption.description
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
}

private extension UILabel {
    func heightOfLabel() -> CGFloat {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return 2*label.frame.height // TODO
    }
}