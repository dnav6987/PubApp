//
//  OrderTableViewCell.swift
//  PubApp
//
//  Created by Dan Navarro on 4/22/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//


/*
    Table cells for the orders page.
 */

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var menuItem: (description: String, price: Float)? {    // The item in this cell
        didSet { updateUI() }
    }
    

    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderDetail: UILabel!
 
    func updateUI() {
        if menuItem != nil {
            // Put the description in the Title and price in the Detail
            if orderTitle != nil { orderTitle.text = menuItem!.description }    // TODO eventually make menuItem.name
            if orderDetail != nil { orderDetail.text = "$" + String(format: "%.2f", menuItem!.price) }
        }
    }    
}
