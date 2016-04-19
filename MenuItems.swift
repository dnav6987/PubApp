//
//  MenuItems.swift
//  PubApp
//
//  Created by Dan Navarro on 4/18/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import Foundation

class MenuItems {
    var items = [String: MenuItem]()
    
    init() {
        items["GhBreadsticks"] = MenuItem(description: "Garlic-Herb Breadsticks with Marinara Sauce",
                                          options: [MenuOption(description: "Small", price: 2.25),
                                            MenuOption(description: "Large", price: 3.75)])
        items["ChBreadsticks"] = MenuItem(description: "Cheese Breadsticks with Marinara",
                                          options: [MenuOption(description: "Small", price: 2.25),
                                        MenuOption(description: "Large", price: 3.75)])
        items["FriedPickles"] = MenuItem(description: "Fried Pickles with Chipotle Mayo",
                                          options: [MenuOption(description: "", price: 2.25)])
        items["FriedMushroom"] = MenuItem(description: "Fried Mushrooms with Homemade Ranch Dressing",
                                         options: [MenuOption(description: "", price: 2.25)])
    }
}

class MenuItem {
    var description: String = ""
    var options = [MenuOption]()
    
    init(description: String, options: [MenuOption]) {
        self.description = description
        self.options = options
    }
    
    init() {}
}

class MenuOption {
    var description: String = ""
    var price: Float = -1.0
    
    init(description: String, price: Float) {
        self.description = description
        self.price = price
    }
    
    init() {}
}