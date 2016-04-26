//
//  Order.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
 TODOs
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