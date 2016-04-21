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
        // APPETIZERS
//        let APPS = ["GhBreadsticks", "ChBreadsticks", "FriedPickles", "FriedMushroom", "Hummus", "MozzSticks", "ChipsSalsa", "FriedMushroom", "Pretzels", ]
        items["GhBreadsticks"] = MenuItem(description: "Garlic-Herb Breadsticks with Marinara Sauce",
                                          options: [MenuOption(description: Options.SMALL, price: 2.25),
                                            MenuOption(description: Options.LARGE, price: 3.75)],
                                          type: foodTypes.APP)
        items["ChBreadsticks"] = MenuItem(description: "Cheese Breadsticks with Marinara",
                                          options: [MenuOption(description: Options.SMALL, price: 2.25),
                                        MenuOption(description: Options.LARGE, price: 3.75)],
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
        // TODO make add ons for salads
        items["SpinachFeta"] = MenuItem(description: "Fresh baby spinach with craisins, toasted walnuts, crumbled feta cheese, sliced apple & lemon poppy seed vinaigrette",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                        type: foodTypes.SALAD)
        items["Cobb"] = MenuItem(description: "Romaine lettuce, chicken, crisp bacon, tomato, avocado, and egg with blue cheese",
                                 options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                 type: foodTypes.SALAD)
        items["Garden"] = MenuItem(description: "Magee's Garden Salad",
                                   options: [MenuOption(description: Options.SMALL, price: 2.25),
                                            MenuOption(description: Options.LARGE, price: 3.75)],
                                   type: foodTypes.SALAD)
        items["Caesar"] = MenuItem(description: "Jack's Casear Salad",
                                   options: [MenuOption(description: Options.SMALL, price: 3.00),
                                            MenuOption(description: Options.LARGE, price: 4.25)],
                                   type: foodTypes.SALAD)
        items["MandarinAlmond"] = MenuItem(description: "Mixed lettuces with mandarin oranges, crisp noodles and slices almonds with Asain peanut dressing",
                                           options: [MenuOption(description: Options.NO_OPTIONS, price: 5.00)],
                                           type: foodTypes.SALAD)
        items["Greek"] = MenuItem(description: "Romaine lettuce, cucumbers, cherry tomatoes, artichoke hearts, pepperoncini, red onion, feta cheese and kalamata olives with a side of hummus and warm pita",
                                  options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                  type: foodTypes.SALAD)
        
        // PANINIS
        items["PestoPanino"] = MenuItem(description: "Grilled chicken, pesto, roasted red peppers and mozzarella on an herbed ciabatta roll",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                        type: foodTypes.PANINI)
        items["TunaPanino"] = MenuItem(description: "Homemade tuna salad with melted American cheese on sliced Italian bread",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                       type: foodTypes.PANINI)
        items["PortobelloPanino"] = MenuItem(description: "Portobello mushrooms with goat cheese, roasted red peppers, spinach & balsamic vinaigrette on an herbed ciabatta roll",
                                             options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                             type: foodTypes.PANINI)
        // BASKETS
        items["FingerBasket"] = MenuItem(description: "Chicken Finger Basket with French fries",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                         type: foodTypes.BASKET)
        items["FishBasket"] = MenuItem(description: "Fish and Chip Basket: Fried haddock with French fries and Tartar sauce",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                       type: foodTypes.BASKET)
        
        // Cold Sandwiches
        
        items["DeliSand"] = MenuItem(description: "TODO need to work on this stull",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                    type: foodTypes.SANDWICH)
        items["TurkeyClub"] = MenuItem(description: "Jack’s Double-Decker Turkey Club",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                       type: foodTypes.SANDWICH)
        items["BLT"] = MenuItem(description: "On toasted white or wheat bread",
                                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.25)],
                                type: foodTypes.SANDWICH)
        items["Flatbread"] = MenuItem(description: "Lettuce, tomato, cucumber, red onion, carrots, cabbage, avocado and dried cranberries in a grilled whole wheat  atbread with balsamic vinaigrette",
                                      options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                      type: foodTypes.SANDWICH)
        
        // Hot Sandwiches
        
        items["Burger"] = MenuItem(description: "Freshly ground in our own meat shop",
                                      options: [MenuOption(description: Options.NO_OPTIONS, price: 4.00)],
                                      type: foodTypes.SANDWICH)
        items["CheeseBurger"] = MenuItem(description: "Cheeseburger",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                         type: foodTypes.SANDWICH)
        items["TurkeyBurger"] = MenuItem(description: "Turkey Burger",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                         type: foodTypes.SANDWICH)
        items["PolarBurger"] = MenuItem(description: "Our signature quarter pounder with grilled onions, mushrooms, bacon & Swiss cheese",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                        type: foodTypes.SANDWICH)
        items["SmokeBurger"] = MenuItem(description: "Choice of beef or turkey burger with Swiss cheese, bacon, crisp onion rings & BBQ sauce",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                        type: foodTypes.SANDWICH)
        items["MangoBurger"] = MenuItem(description: "Locally made black bean & spinach veggie burger serverd on a bulkie roll with lettuce & tomato",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                        type: foodTypes.SANDWICH)
        items["PhillyCheese"] = MenuItem(description: "Served with grilled onions and peppers on a toasted roll",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                                         type: foodTypes.SANDWICH)
        items["Falafel"] = MenuItem(description: "Grilled falafel in our home-made pita with lettuce, tomato & tzatziki",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                    type: foodTypes.SANDWICH)
        items["ChickenParm"] = MenuItem(description: "Deep fried chicken patty with marinara, mozarella and parmesan on a bulkie roll",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                                    type: foodTypes.SANDWICH)
        items["GrilledCheese"] = MenuItem(description: "Classic Grilled Cheese Sandwich (V)",
                                          options: [MenuOption(description: Options.NO_OPTIONS, price: 3.00)],
                                          type: foodTypes.SANDWICH)
        
        
        // BURRITOS & WRAPS
        items["FishTaco"] = MenuItem(description: "A  our tortilla filled with fried fish, shredded cabbage, avocado, Monterey jack cheese, salsa & green onion-mayo",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                     type: foodTypes.WRAP)
        items["Burrito"] = MenuItem(description: "A tortilla stuffed with yellow rice, jack cheese, onions, lettuce and tomatoes with your choice of grilled veggies (V), chicken or beef. Sour cream and salsa on the side",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                    type: foodTypes.WRAP)
        items["CaesarWrap"] = MenuItem(description: "The classic wrap of romaine, parmesan cheese, croutons and Caesar dressing with sliced grilled chicken breast",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                                       type: foodTypes.WRAP)
        items["BuffWrap"] = MenuItem(description: "Buffalo chicken strips, lettuce, tomato and blue cheese dressing in a  our tortilla",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                                    type: foodTypes.WRAP)
        items["CobbWrap"] = MenuItem(description: "A chopped salad in a  our tortilla: romaine lettuce, chicken, crisp bacon, tomato, avocado and egg with blue cheese dressing",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                                     type: foodTypes.WRAP)
        items["TempehWrap"] = MenuItem(description: "Tandoori marinated tempeh with curried cauli ower, quinoa and spicy eggplant relish",
                                       options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                       type: foodTypes.WRAP)
        
        // PIZZAS
        items["CheesePizza"] = MenuItem(description: "Basic Cheese Pizza (V)",
                                        options: [MenuOption(description: "10 inch", price: 5.50),
                                                MenuOption(description: "16 inch", price: 8.95)],
                                     type: foodTypes.PIZZA)
        items["BbqPizza"] = MenuItem(description: "Shredded chicken smothered in BBQ sauce with mozzarella cheese",
                                        options: [MenuOption(description: "10 inch", price: 7.00),
                                                MenuOption(description: "16 inch", price: 13.00)],
                                        type: foodTypes.PIZZA)
        items["BuffPizza"] = MenuItem(description: "Chicken, mozzarella, blue cheese sauce and a squirt of red hot",
                                      options: [MenuOption(description: "10 inch", price: 7.00),
                                        MenuOption(description: "16 inch", price: 13.00)],
                                      type: foodTypes.PIZZA)
        
        // CALZONES
        
        items["PestoCalzone"] = MenuItem(description: "Pesto Chicken Calzone",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                                         type: foodTypes.PIZZA)
        items["BuffCalzone"] = MenuItem(description: "Buffalo Chicken Calzone",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 7.25)],
                                        type: foodTypes.PIZZA)
        items["CheeseCalzone"] = MenuItem(description: "Cheese Calzone",
                                         options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                                         type: foodTypes.PIZZA)
        
        // SIDES
        items["FrenchFries"] = MenuItem(description: "French Fries",
                                       options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.25)],
                                       type: foodTypes.SIDE)
        items["SteakFries"] = MenuItem(description: "Steak Fries",
                                        options: [MenuOption(description: Options.SMALL, price: 2.25),
                                                MenuOption(description: Options.LARGE, price: 2.75)],
                                        type: foodTypes.SIDE)
        items["FajitaFries"] = MenuItem(description: "Fajita Fries",
                                        options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.25)],
                                        type: foodTypes.SIDE)
        items["OnionRings"] = MenuItem(description: "Onion Rings",
                                        options: [MenuOption(description: Options.SMALL, price: 1.75),
                                                MenuOption(description: Options.LARGE, price: 2.50)],
                                        type: foodTypes.SIDE)
        items["SweetFries"] = MenuItem(description: "Sweet Potato Fries",
                                        options: [MenuOption(description: Options.SMALL, price: 2.25),
                                                MenuOption(description: Options.LARGE, price: 2.95)],
                                        type: foodTypes.SIDE)
        items["Guacomole"] = MenuItem(description: "Guacomole",
                                        options: [MenuOption(description: Options.NO_OPTIONS, price: 1.50)],
                                        type: foodTypes.SIDE)
        
        // BEVERAGES
        
        items["Fountain"] = MenuItem(description: "Refillable Fountain Beverage",
                                     options: [MenuOption(description: Options.NO_OPTIONS, price: 1.25)],
                                     type: foodTypes.BEVERAGE)
        items["Milk"] = MenuItem(description: "Pint of Milk",
                                 options: [MenuOption(description: Options.NO_OPTIONS, price: 1.19)],
                                 type: foodTypes.BEVERAGE)
        items["Coffee"] = MenuItem(description: "Coffee",
                                   options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                                   type: foodTypes.BEVERAGE)
        items["Tea"] = MenuItem(description: "Tea",
                                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                                type: foodTypes.BEVERAGE)
        items["IcedTea"] = MenuItem(description: "Fresh Brewed Iced Tea",
                                    options: [MenuOption(description: Options.NO_OPTIONS, price: 1.20)],
                                    type: foodTypes.BEVERAGE)
        
        // TODO gluten free bread and pizza dough, pizza toppings add (V) and (VE), add ons and additional options in a drop down menu maybe
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