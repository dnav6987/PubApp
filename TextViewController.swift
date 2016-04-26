//
//  TextViewController.swift
//  Professor
//
//  Created by Dan Navarro on 2/25/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var text: String = "" { didSet { textView?.text = text } }
    
    @IBOutlet weak var textView: UITextView! { didSet { textView.text = text } }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        
        set {
            super.preferredContentSize = newValue
        }
    }
}
