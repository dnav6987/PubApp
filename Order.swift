//
//  Order.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
 TODOs
 make all labels have lines = 0 (they cut off on my phone)
 get all sides, toppings, options in one table view with 3 prototype cells and sections
 see if back button can be set programatically and look better
 
 $ on prices
 make a menuItem as string function where it goes option, name, addons, price
*/
import Foundation

struct Order {
    static var defaults = NSUserDefaults.standardUserDefaults()
    static let ORDER_STRING = "Order"
    static let PRICES_STRING = "Prices"
}

struct OrderItem {
    var name: String!
    var price: Float!
}