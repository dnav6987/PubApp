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
            
            for option in menuItem.options  {
                let button = UIButton(type: UIButtonType.System) as UIButton
                button.addTarget(self, action: #selector(MenuItemViewController.addToOrder(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                button.setTitle(option.description+" $"+String(format: "%.2f", option.price), forState: .Normal)
                button.sizeToFit()
                let origin = CGPoint(x: view.frame.width/2 - button.frame.width/2, y: nextButtonHeight)
                button.frame = CGRect(origin: origin, size: CGSize(width: button.frame.width, height: Constants.BUTTON_HEIGHT))
                view.addSubview(button)
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
            let optionSeparatedFromPrice = sender.currentTitle!.characters.split{ $0 == "$" }.map(String.init)
            let thisOrderItem = optionSeparatedFromPrice[0] + menuItem.description + " $" + optionSeparatedFromPrice[1]
            print(thisOrderItem)
            
            var test = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String]
            if test != nil {
                test?.append(thisOrderItem)
                Order.defaults.setObject(test, forKey: Order.ORDER_STRING)
                Order.defaults.synchronize()
            } else {
                Order.defaults.setObject([thisOrderItem], forKey: Order.ORDER_STRING)
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

private extension Float {
    func floatAsPriceString() -> String {
        let format = ".2"
        return String(format: "%\(format)f", self)
    }
}