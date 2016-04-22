//
//  OrderTableViewCell.swift
//  PubApp
//
//  Created by Dan Navarro on 4/22/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var order: String? {
        didSet {
            updateUI()
        }
    }
    

    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderDetail: UILabel!
 
    func updateUI() {
        if order != nil {
            if orderTitle != nil { orderTitle.text = order }
            if orderDetail != nil { orderDetail.text = "TEST1,2" }
        }
    }
    
}
