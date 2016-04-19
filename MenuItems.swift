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
    
    struct foodTypes {
        static let APP = "APP"
        static let SALAD = "SALAD"
    }
    
    init() {
        // APPETIZERS
//        let APPS = ["GhBreadsticks", "ChBreadsticks", "FriedPickles", "FriedMushroom", "Hummus", "MozzSticks", "ChipsSalsa", "FriedMushroom", "Pretzels", ]
        items["GhBreadsticks"] = MenuItem(description: "Garlic-Herb Breadsticks with Marinara Sauce",
                                          options: [MenuOption(description: "Small", price: 2.25),
                                            MenuOption(description: "Large", price: 3.75)],
                                          type: foodTypes.APP)
        items["ChBreadsticks"] = MenuItem(description: "Cheese Breadsticks with Marinara",
                                          options: [MenuOption(description: "Small", price: 2.25),
                                        MenuOption(description: "Large", price: 3.75)],
                                            type: foodTypes.APP)
        items["FriedPickles"] = MenuItem(description: "Fried Pickles with Chipotle Mayo",
                                         options: [MenuOption(description: "", price: 4.75)],
                                         type: foodTypes.APP)
        items["FriedMushroom"] = MenuItem(description: "Fried Mushrooms with Homemade Ranch Dressing",
                                          options: [MenuOption(description: "", price: 4.95)],
                                          type: foodTypes.APP)
        items["Hummus"] = MenuItem(description: "Hummus & Pita with Veggies",
                                   options: [MenuOption(description: "", price: 3.25)],
                                   type: foodTypes.APP)
        items["MozzSticks"] = MenuItem(description: "Mozzarella Sticks",
                                       options: [MenuOption(description: "", price: 4.95)],
                                       type: foodTypes.APP)
        items["ChipsSalsa"] = MenuItem(description: "Tortilla Chips and Salsa",
                                       options: [MenuOption(description: "", price: 2.50)],
                                       type: foodTypes.APP)
        items["FriedMushroom"] = MenuItem(description: "Fried Mushrooms with Homemade Ranch Dressing",
                                          options: [MenuOption(description: "", price: 2.25)],
                                          type: foodTypes.APP)
        items["Pretzels"] = MenuItem(description: "Two Soft Pretzels, Served Warm",
                                     options: [MenuOption(description: "", price: 2.75)],
                                     type: foodTypes.APP)
        items["Fingers"] = MenuItem(description: "Chicken Fingers",
                                    options: [MenuOption(description: "Buffalo", price: 5.95),
                                            MenuOption(description: "Plain", price: 5.95)],
                                    type: foodTypes.APP)
        items["Wings"] = MenuItem(description: "Chicken Wings",
                                  options: [MenuOption(description: "Buffalo", price: 6.25),
                                            MenuOption(description: "BBQ", price: 6.25),
                                            MenuOption(description: "Honey Mustard", price: 6.25)],
                                  type: foodTypes.APP)
        items["Quesadilla"] = MenuItem(description: "Chicken Wings",
                                       options: [MenuOption(description: "Plain", price: 4.75),
                                                MenuOption(description: "Add Veggies", price: 5.50),
                                                MenuOption(description: "Add Chicken", price: 5.50)],
                                       type: foodTypes.APP)
        
        // SALADS
        items["SpinachFeta"] = MenuItem(description: "Fresh baby spinach with craisins, toasted walnuts, crumbled feta cheese, sliced apple & lemon poppy seed vinaigrette",
                                        options: [MenuOption(description: "Regular", price: 6.50)],
                                        type: foodTypes.SALAD)
        items["Cobb"] = MenuItem(description: "Romaine lettuce, chicken, crisp bacon, tomato, avocado, and egg with blue cheese",
                                 options: [MenuOption(description: "Regular", price: 6.25)],
                                 type: foodTypes.SALAD)
        items["Garden"] = MenuItem(description: "Magee's Garden Salad",
                                   options: [MenuOption(description: "Small", price: 2.25),
                                            MenuOption(description: "Large", price: 3.75)],
                                   type: foodTypes.SALAD)
        items["Caesar"] = MenuItem(description: "Jack's Casear Salad",
                                   options: [MenuOption(description: "Small", price: 3.00),
                                            MenuOption(description: "Large", price: 4.25)],
                                   type: foodTypes.SALAD)
        items["MandarinAlmond"] = MenuItem(description: "Mixed lettuces with mandarin oranges, crisp noodles and slices almonds with Asain peanut dressing",
                                           options: [MenuOption(description: "Regular", price: 5.00)],
                                           type: foodTypes.SALAD)
        items["Greek"] = MenuItem(description: "Romaine lettuce, cucumbers, cherry tomatoes, artichoke hearts, pepperoncini, red onion, feta cheese and kalamata olives with a side of hummus and warm pita",
                                  options: [MenuOption(description: "Regular", price: 5.25)],
                                  type: foodTypes.SALAD)
        
        // TODO make add ons for salads
    }
}

class MenuItem {
    var type = ""
    var description = ""
    var options = [MenuOption]()
    var addOns = [MenuOption]()
    
    init(description: String, options: [MenuOption], type: String) {
        self.description = description
        self.options = options
        self.type = type
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