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
            
            var nextButtonHeight = descriptionLabel.heightOfLabel() + 1
            
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
                                CGFloat(menuItem.options.count) + descriptionLabel.heightOfLabel())
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
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return 2*label.frame.height
    }
}
