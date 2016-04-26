//
//  Order.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
 TODOs
 -make all labels have lines = 0 (they cut off on my phone)
 -get all sides, toppings, options in one table view with 3 prototype cells and sections?
 -when you get to order from menu it ruins the navigation bar
 -try to get segue from fake button from menu to detailed menu
 -try to keep them all in tabview controller
 -when there is no options and it autosegues, still need to make a button to progress in case they go back
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