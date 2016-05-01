//
//  TextViewController.swift
//  Professor
//
//  Taken from a lecture by Eric Chown

/*
    This is a view for displaying popovers that contain text. The view is sized so that it just fits the text
*/

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
