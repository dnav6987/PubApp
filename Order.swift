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
 -when there is no options and it autosegues, still need to make a button to progress in case they go back
 -add/delete the tab where things are customized. also, do something about it not having a menuItem, causes crash
 -when you select an option, then go through the order flow and then go all the way back, the options disappear next time
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