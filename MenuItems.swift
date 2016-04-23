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
    
    struct Options {
        static let NO_OPTIONS = "Regular"
        static let SMALL = "Small"
        static let LARGE = "Large"
    }
    
    struct foodTypes {
        static let APP = "APP"
        static let SALAD = "SALAD"
        static let PANINI = "PANINI"
        static let BASKET = "BASKET"
        static let WRAP = "WRAP"
        static let PIZZA = "PIZZA"
        static let CALZONE = "CALZONE"
        static let SIDE = "SIDE"
        static let BEVERAGE = "BEVERAGE"
        static let SANDWICH = "SANDWICH"
    }
    
    init() {
        // TODO remove descriptions that == the name
        
        // APPETIZERS
        items["GhBreadsticks"] = MenuItem(name: "Garlic - Herb Breadsticks with Marinara Sauce",
                                          description: "Garlic-Herb Breadsticks with Marinara Sauce",
                                          options: [MenuOption(description: Options.SMALL, price: 2.25),
                                            MenuOption(description: Options.LARGE, price: 3.75)],
                                          type: foodTypes.APP)
        items["ChBreadsticks"] = MenuItem(name: "Cheese Breadsticks with Marinara Sauce",
                                          description: "Cheese Breadsticks with Marinara",
                                          options: [MenuOption(description: Options.SMALL, price: 2.25),
                                        MenuOption(description: Options.LARGE, price: 3.75)],
                                          type: foodTypes.APP)
        items["FriedPickles"] = MenuItem(name: "Fried Pickles with Chipotle Mayo",
                                         description: "Fried Pickles with Chipotle Mayo",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                         type: foodTypes.APP)
        items["FriedMushroom"] = MenuItem(name: "Fried Mushrooms with Homemade Ranch Dressing",
                                          description: "Fried Mushrooms with Homemade Ranch Dressing",
                                          options: [MenuOption(description: Options.NO_OPTIONS, price: 4.95)],
                                          type: foodTypes.APP)
        items["Hummus"] = MenuItem(name: "Hummus & Pita with Veggies",
                                   description: "Hummus & Pita with Veggies",
                                   options: [MenuOption(description: Options.NO_OPTIONS, price: 3.25)],
                                   type: foodTypes.APP)
        items["MozzSticks"] = MenuItem(name: "Mozzarella Sticks",
                                       description: "Mozzarella Sticks",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 4.95)],
                                       type: foodTypes.APP)
        items["ChipsSalsa"] = MenuItem(name: "Tortilla Chips and Salsa",
                                       description: "Tortilla Chips and Salsa",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 2.50)],
                                       type: foodTypes.APP)
        items["Pretzels"] = MenuItem(name: "Two Soft Pretzels, Served Warm",
                                     description: "Two Soft Pretzels, Served Warm",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 2.75)],
                                     type: foodTypes.APP)
        items["Fingers"] = MenuItem(name: "Chicken Fingers",
                                    description: "Chicken Fingers",
                                    options: [MenuOption(description: "Buffalo", price: 5.95),
                                            MenuOption(description: "Plain", price: 5.95)],
                                    type: foodTypes.APP)
        items["Wings"] = MenuItem(name: "Chicken Wings",
                                  description: "Chicken Wings",
                                  options: [MenuOption(description: "Buffalo", price: 6.25),
                                            MenuOption(description: "BBQ", price: 6.25),
                                            MenuOption(description: "Honey Mustard", price: 6.25)],
                                  type: foodTypes.APP)
        items["Quesadilla"] = MenuItem(name: "Monterey Jack Cheese Quesadilla",
                                       description: "Monterey Jack Cheese Quesadilla",
                                       options: [MenuOption(description: "Plain", price: 4.75),
                                                MenuOption(description: "Add Veggies", price: 5.50),
                                                MenuOption(description: "Add Chicken", price: 5.50)],
                                       type: foodTypes.APP)
        
        // SALADS
        // TODO make add ons for salads
        items["SpinachFeta"] = MenuItem(name: "Spinach & Feta Salad",
                                        description: "Fresh baby spinach with craisins, toasted walnuts, crumbled feta cheese, sliced apple & lemon poppy seed vinaigrette",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                        type: foodTypes.SALAD)
        items["Cobb"] = MenuItem(name: "Cobb Salad",
                                 description: "Romaine lettuce, chicken, crisp bacon, tomato, avocado, and egg with blue cheese",
                                 options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                 type: foodTypes.SALAD)
        items["Garden"] = MenuItem(name: "Magee's Garden Salad (VE)",
                                   description: "Magee's Garden Salad",
                                   options: [MenuOption(description: Options.SMALL, price: 2.25),
                                            MenuOption(description: Options.LARGE, price: 3.75)],
                                   type: foodTypes.SALAD)
        items["Caesar"] = MenuItem(name: "Jack's Casear Salad",
                                   description: "Jack's Casear Salad",
                                   options: [MenuOption(description: Options.SMALL, price: 3.00),
                                            MenuOption(description: Options.LARGE, price: 4.25)],
                                   type: foodTypes.SALAD)
        items["MandarinAlmond"] = MenuItem(name: "Mandarin Almond Salad (V)",
                                           description: "Mixed lettuces with mandarin oranges, crisp noodles and slices almonds with Asain peanut dressing",
                                           options: [MenuOption(description: Options.NO_OPTIONS, price: 5.00)],
                                           type: foodTypes.SALAD)
        items["Greek"] = MenuItem(name: "Greek Salad with Hummus (V)",
                                  description: "Romaine lettuce, cucumbers, cherry tomatoes, artichoke hearts, pepperoncini, red onion, feta cheese and kalamata olives with a side of hummus and warm pita",
                                  options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                  type: foodTypes.SALAD)
        
        // PANINIS
        items["PestoPanino"] = MenuItem(name: "Chicken Pesto PAnino",
                                        description: "Grilled chicken, pesto, roasted red peppers and mozzarella on an herbed ciabatta roll",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                        type: foodTypes.PANINI)
        items["TunaPanino"] = MenuItem(name: "Tuna Melt Panino",
                                       description: "Homemade tuna salad with melted American cheese on sliced Italian bread",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                       type: foodTypes.PANINI)
        items["PortobelloPanino"] = MenuItem(name: "Portobello & Goat Cheese Panino (V)",
                                             description: "Portobello mushrooms with goat cheese, roasted red peppers, spinach & balsamic vinaigrette on an herbed ciabatta roll",
                                             options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                             type: foodTypes.PANINI)
        // BASKETS
        items["FingerBasket"] = MenuItem(name: "Chicken Finger Basket",
                                         description: "Chicken Finger Basket with French fries",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                         type: foodTypes.BASKET)
        items["FishBasket"] = MenuItem(name: "Fish and Chip Basket",
                                       description: "Fish and Chip Basket: Fried haddock with French fries and Tartar sauce",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                       type: foodTypes.BASKET)
        
        // Cold Sandwiches
        
        items["DeliSand"] = MenuItem(name: "Jack's Deli Sandwich",
                                     description: "TODO need to work on this stull",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                     type: foodTypes.SANDWICH)
        items["TurkeyClub"] = MenuItem(name: "Jack’s Double-Decker Turkey Club",
                                       description: "Jack’s Double-Decker Turkey Club",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                       type: foodTypes.SANDWICH)
        items["BLT"] = MenuItem(name: "BLT Sandwich",
                                description: "On toasted white or wheat bread", // TODO
                                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.25)],
                                type: foodTypes.SANDWICH)
        items["Flatbread"] = MenuItem(name: "Veggie Flatbread (VE)",
                                      description: "Lettuce, tomato, cucumber, red onion, carrots, cabbage, avocado and dried cranberries in a grilled whole wheat  atbread with balsamic vinaigrette",
                                      options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                      type: foodTypes.SANDWICH)
        
        // Hot Sandwiches
        
        items["Burger"] = MenuItem(name: "Hamburger",
                                   description: "Freshly ground in our own meat shop",
                                   options: [MenuOption(description: Options.NO_OPTIONS, price: 4.00)],
                                   type: foodTypes.SANDWICH)
        items["CheeseBurger"] = MenuItem(name: "Cheeseburger",
                                         description: "Cheeseburger",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                         type: foodTypes.SANDWICH)
        items["TurkeyBurger"] = MenuItem(name: "Turkey Burger",
                                         description: "Turkey Burger",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                         type: foodTypes.SANDWICH)
        items["PolarBurger"] = MenuItem(name: "Polar Bear Burger",
                                        description: "Our signature quarter pounder with grilled onions, mushrooms, bacon & Swiss cheese",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                        type: foodTypes.SANDWICH)
        items["SmokeBurger"] = MenuItem(name: "Smoke House Burger",
                                        description: "Choice of beef or turkey burger with Swiss cheese, bacon, crisp onion rings & BBQ sauce",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                        type: foodTypes.SANDWICH)
        items["MangoBurger"] = MenuItem(name: "Blue Mango Garden Burger (VE)",
                                        description: "Locally made black bean & spinach veggie burger serverd on a bulkie roll with lettuce & tomato",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                        type: foodTypes.SANDWICH)
        items["PhillyCheese"] = MenuItem(name: "Shaved Philly Steak & Cheese",
                                         description: "Served with grilled onions and peppers on a toasted roll",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                         type: foodTypes.SANDWICH)
        items["Falafel"] = MenuItem(name: "Flat Top Falafel with Tzatziki Sauce (V)",
                                    description: "Grilled falafel in our home-made pita with lettuce, tomato & tzatziki",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                    type: foodTypes.SANDWICH)
        items["ChickenParm"] = MenuItem(name: "Chicken Parmesan Sandwich",
                                        description: "Deep fried chicken patty with marinara, mozarella and parmesan on a bulkie roll",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                        type: foodTypes.SANDWICH)
        items["GrilledCheese"] = MenuItem(name: "Classic Grilled Cheesesandwich (V)",
                                          description: "Classic Grilled Cheese Sandwich (V)",
                                          options: [MenuOption(description: Options.NO_OPTIONS, price: 3.00)],
                                          type: foodTypes.SANDWICH)
        
        
        // BURRITOS & WRAPS
        items["FishTaco"] = MenuItem(name: "Fish Taco",
                                     description: "A  our tortilla filled with fried fish, shredded cabbage, avocado, Monterey jack cheese, salsa & green onion-mayo",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                     type: foodTypes.WRAP)
        items["Burrito"] = MenuItem(name: "Burrito \"El Grande\"",
                                    description: "A tortilla stuffed with yellow rice, jack cheese, onions, lettuce and tomatoes with your choice of grilled veggies (V), chicken or beef. Sour cream and salsa on the side",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                    type: foodTypes.WRAP)
        items["CaesarWrap"] = MenuItem(name: "Chicken Caesar Wrap",
                                       description: "The classic wrap of romaine, parmesan cheese, croutons and Caesar dressing with sliced grilled chicken breast",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                       type: foodTypes.WRAP)
        items["BuffWrap"] = MenuItem(name: "Buffalo Chicken & Blue Cheese Wrap",
                                     description: "Buffalo chicken strips, lettuce, tomato and blue cheese dressing in a  our tortilla",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                     type: foodTypes.WRAP)
        items["CobbWrap"] = MenuItem(name: "Cobb Salad Wrap",
                                     description: "A chopped salad in a  our tortilla: romaine lettuce, chicken, crisp bacon, tomato, avocado and egg with blue cheese dressing",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                     type: foodTypes.WRAP)
        items["TempehWrap"] = MenuItem(name: "Tandoori Tempeh Wrap (VE)",
                                       description: "Tandoori marinated tempeh with curried cauli ower, quinoa and spicy eggplant relish",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                       type: foodTypes.WRAP)
        
        // PIZZAS
        items["CheesePizza"] = MenuItem(name: "Basic Cheese Pizza (V)",
                                        description: "Basic Cheese Pizza (V)",
                                        options: [MenuOption(description: "10 inch", price: 5.50),
                                                MenuOption(description: "16 inch", price: 8.95)],
                                        type: foodTypes.PIZZA)
        items["BbqPizza"] = MenuItem(name: "BBQ Chicken Pizza",
                                     description: "Shredded chicken smothered in BBQ sauce with mozzarella cheese",
                                     options: [MenuOption(description: "10 inch", price: 7.00),
                                                MenuOption(description: "16 inch", price: 13.00)],
                                     type: foodTypes.PIZZA)
        items["BuffPizza"] = MenuItem(name: "Buffalo Chicken Pizza",
                                      description: "Chicken, mozzarella, blue cheese sauce and a squirt of red hot",
                                      options: [MenuOption(description: "10 inch", price: 7.00),
                                        MenuOption(description: "16 inch", price: 13.00)],
                                      type: foodTypes.PIZZA)
        
        // CALZONES
        
        items["PestoCalzone"] = MenuItem(name: "Pesto Chicken Calzone",
                                         description: "Pesto Chicken Calzone",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                         type: foodTypes.PIZZA)
        items["BuffCalzone"] = MenuItem(name: "Buffalo Chicken Calzone",
                                        description: "Buffalo Chicken Calzone",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 7.25)],
                                        type: foodTypes.PIZZA)
        items["CheeseCalzone"] = MenuItem(name: "Cheese Calzone",
                                          description: "Cheese Calzone",
                                          options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                          type: foodTypes.PIZZA)
        
        // SIDES
        items["FrenchFries"] = MenuItem(name: "French Fries",
                                        description: "French Fries",
                                        options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.25)],
                                       type: foodTypes.SIDE)
        items["SteakFries"] = MenuItem(name: "Steak Fries",
                                       description: "Steak Fries",
                                       options: [MenuOption(description: Options.SMALL, price: 2.25),
                                                MenuOption(description: Options.LARGE, price: 2.75)],
                                       type: foodTypes.SIDE)
        items["FajitaFries"] = MenuItem(name: "Fajita Fries",
                                        description: "Fajita Fries",
                                        options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.25)],
                                        type: foodTypes.SIDE)
        items["OnionRings"] = MenuItem(name: "Onion Rings",
                                       description: "Onion Rings",
                                       options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.50)],
                                       type: foodTypes.SIDE)
        items["SweetFries"] = MenuItem(name: "Sweet Potato Fries",
                                       description: "Sweet Potato Fries",
                                       options: [MenuOption(description: Options.SMALL, price: 2.25),
                                                MenuOption(description: Options.LARGE, price: 2.95)],
                                       type: foodTypes.SIDE)
        items["Guacomole"] = MenuItem(name: "Guacomole",
                                      description: "Guacomole",
                                      options: [MenuOption(description: Options.NO_OPTIONS, price: 1.50)],
                                      type: foodTypes.SIDE)
        
        // BEVERAGES
        
        items["Fountain"] = MenuItem(name: "Refillable Fountain Beverage",
                                     description: "Refillable Fountain Beverage",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 1.25)],
                                     type: foodTypes.BEVERAGE)
        items["Milk"] = MenuItem(name: "Pint of Milk",
                                 description: "Pint of Milk",
                                 options: [MenuOption(description: Options.NO_OPTIONS, price: 1.19)],
                                 type: foodTypes.BEVERAGE)
        items["Coffee"] = MenuItem(name: "Coffee",
                                   description: "Coffee",
                                   options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                                   type: foodTypes.BEVERAGE)
        items["Tea"] = MenuItem(name: "Tea",
                                description: "Tea",
                                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                                type: foodTypes.BEVERAGE)
        items["IcedTea"] = MenuItem(name: "Fresh Brewed Iced Tea",
                                    description: "Fresh Brewed Iced Tea",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 1.20)],
                                    type: foodTypes.BEVERAGE)
        
        // TODO gluten free bread and pizza dough, pizza toppings add (V) and (VE), add ons and additional options in a drop down menu maybe
    }
}

class MenuItem {
    var name = ""
    var description = ""
    var options = [MenuOption]()
    var addOns = [MenuOption]()
    var type = ""
    
    init(name: String, description: String, options: [MenuOption], type: String) {
        self.name = name
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