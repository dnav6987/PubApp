//
//  Order.swift
//  PubApp
//
//  Created by Dan Navarro on 4/21/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import Foundation

/*
 - add a name and ID fields in order view (perhaps make a UIViewcontroller that has the current order view plus the additional fields
 - once the order is placed, put a loading spinner and wait for response from server
- respond with alert (order recieved, could not reach server, invalid ID)
 */

struct Order {
    static var defaults = NSUserDefaults.standardUserDefaults()
    static let ORDER_STRING = "Order"
    static let PRICES_STRING = "Prices"
    static let NAME = "Name"
    static let ID = "ID"
}