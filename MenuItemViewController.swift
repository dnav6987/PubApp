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
        static let BUTTON_SIZE = CGSize(width: 100, height: 25)
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet { if menuItem != nil { descriptionLabel.text = menuItem.description } }
    }
    
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        if menuItem != nil && view != nil {
            
            var nextButtonHeight = UILabel.heightOfLabel(descriptionLabel.frame.width,
                                                         text: descriptionLabel.text!,
                                                         font: descriptionLabel.font!) + 1
            
            for option in menuItem.options  {
                let button = UIButton(type: UIButtonType.System) as UIButton
                button.setTitle(option.description + " $\(option.price)", forState: .Normal)
                let origin = CGPoint(x: view.frame.width/2 - Constants.BUTTON_SIZE.width/2, y: nextButtonHeight)
                button.frame = CGRect(origin: origin, size: Constants.BUTTON_SIZE)
                view.addSubview(button)
                nextButtonHeight += Constants.BUTTON_SIZE.height + 1
            }
        }
    }

    override var preferredContentSize: CGSize {
        get {
            if view != nil && presentingViewController != nil && menuItem != nil && descriptionLabel != nil {
                let sizeThatFits = view.sizeThatFits(presentingViewController!.view.bounds.size)
                return CGSize(width: sizeThatFits.width,
                              height: CGFloat(menuItem.options.count)*Constants.BUTTON_SIZE.height +
                                CGFloat(menuItem.options.count) +
                                UILabel.heightOfLabel(descriptionLabel.frame.width,
                                    text: descriptionLabel.text!,
                                    font: descriptionLabel.font!))
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}

private extension UILabel {
    static func heightOfLabel(width: CGFloat, text: String, font: UIFont) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}
