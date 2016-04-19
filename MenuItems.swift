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
                                          options: [MenuOption(description: "", price: 4.75)])
        items["FriedMushroom"] = MenuItem(description: "Fried Mushrooms with Homemade Ranch Dressing",
                                          options: [MenuOption(description: "", price: 4.95)])
        items["Hummus"] = MenuItem(description: "Hummus & Pita with Veggies",
                                   options: [MenuOption(description: "", price: 3.25)])
        items["MozzSticks"] = MenuItem(description: "Mozzarella Sticks",
                                       options: [MenuOption(description: "", price: 4.95)])
        items["ChipsSalsa"] = MenuItem(description: "Tortilla Chips and Salsa",
                                          options: [MenuOption(description: "", price: 2.50)])
        items["FriedMushroom"] = MenuItem(description: "Fried Mushrooms with Homemade Ranch Dressing",
                                          options: [MenuOption(description: "", price: 2.25)])
        items["Pretzels"] = MenuItem(description: "Two Soft Pretzels, Served Warm",
                                          options: [MenuOption(description: "", price: 2.75)])
        items["Fingers"] = MenuItem(description: "Chicken Fingers",
                                    options: [MenuOption(description: "Buffalo", price: 5.95),
                                            MenuOption(description: "Plain", price: 5.95)])
        items["Wings"] = MenuItem(description: "Chicken Wings",
                                  options: [MenuOption(description: "Buffalo", price: 6.25),
                                            MenuOption(description: "BBQ", price: 6.25),
                                            MenuOption(description: "Honey Mustard", price: 6.25)])
        items["Quesadilla"] = MenuItem(description: "Chicken Wings",
                                  options: [MenuOption(description: "Plain", price: 4.75),
                                    MenuOption(description: "Add Veggies", price: 5.50),
                                    MenuOption(description: "Add Chicken", price: 5.50)])
        
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