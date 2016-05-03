//
//  Order.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    This is used to globally store the order information and remember it between launches.
    The strings the identifiers used for object names in the defaults.
*/

/* TODOs:
        - make other people's order feed based on smash tag. search by name within the server
        - search menu items by name and by (V), (VE)
        - store a (or a few) favorite items
*/

import Foundation

struct Order {
    static var defaults = NSUserDefaults.standardUserDefaults()
    static let ORDER_STRING = "Order"
    static let PRICES_STRING = "Prices"
    static let NAME = "Name"
    static let ID = "ID"
    static let FAVORITES_COUNTS = "Fav Count"
    static let FAVORITES_PRICES = "Fav price"
}