//
//  MenuItems.swift
//  PubApp
//
//  Created by Dan Navarro on 4/18/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    The most painful file to write...
 
    This is the menu that the app uses. All of the items are taken from Jack Magee's Pub's menu.
    Items have a name, description and modifiers.
        - Options are choices that must be made about an item (i.e. size, or what type of sandwich meat, etc.)
        - Sides are side orders that can come with the meal
        - add ons and toppings can be added to the order
 
    The items are divided by type as in the real menu
*/

import Foundation

class MenuItems {
    // all of the items
    var items = [MenuItem]()
    
    // item grouped by type
    var menu = [[MenuItem]]()
    var apps = [MenuItem]()
    var salads = [MenuItem]()
    var panini = [MenuItem]()
    var baskets = [MenuItem]()
    var coldSandwiches = [MenuItem]()
    var hotSandwiches = [MenuItem]()
    var wraps = [MenuItem]()
    var pizzas = [MenuItem]()
    var calzones = [MenuItem]()
    var sides = [MenuItem]()
    var beverages = [MenuItem]()
    
    // Some standard options
    struct Options {
        static let NO_OPTIONS = "Regular"
        static let SMALL = "Small"
        static let LARGE = "Large"
    }
    
    // The food groupings
    struct foodTypes {
        static let APP = "APPETIZERS"
        static let SALAD = "SALADS"
        static let PANINI = "PANINI SANDWICHES"
        static let BASKET = "BASKETS"
        static let COLD_SANDWICH = "COLD SANDWICHES"
        static let HOT_SANDWICH = "HOT SANDWICHES"
        static let WRAP = "BUTTIRTOS & WRAPS"
        static let PIZZA = "PIZZA"
        static let CALZONE = "CALZONE"
        static let SIDE = "SIDE ORDERS"
        static let BEVERAGE = "BEVERAGEs"
    }
    
    init() {
        // APPETIZERS
        items = [
            MenuItem(name: "Garlic-Herb Breadsticks with Marinara Sauce",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 2.25),
                    MenuOption(description: Options.LARGE, price: 3.75)],
                type: foodTypes.APP),
            MenuItem(name: "Cheese Breadsticks with Marinara Sauce",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 2.25),
                    MenuOption(description: Options.LARGE, price: 3.75)],
                type: foodTypes.APP),
            MenuItem(name: "Fried Pickles with Chipotle Mayo",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                type: foodTypes.APP),
            MenuItem(name: "Fried Mushrooms with Homemade Ranch Dressing",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.95)],
                type: foodTypes.APP),
            MenuItem(name: "Hummus & Pita with Veggies",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 3.25)],
                type: foodTypes.APP),
            MenuItem(name: "Mozzarella Sticks",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.95)],
                type: foodTypes.APP),
            MenuItem(name: "Tortilla Chips and Salsa",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 2.50)],
                type: foodTypes.APP),
            MenuItem(name: "Two Soft Pretzels, Served Warm",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 2.75)],
                type: foodTypes.APP),
            MenuItem(name: "Chicken Fingers",
                description: "",
                options: [MenuOption(description: "Buffalo", price: 5.95),
                    MenuOption(description: "Plain", price: 5.95)],
                type: foodTypes.APP),
            MenuItem(name: "Chicken Wings",
                description: "",
                options: [MenuOption(description: "Buffalo", price: 6.25),
                    MenuOption(description: "BBQ", price: 6.25),
                    MenuOption(description: "Honey Mustard", price: 6.25)],
                type: foodTypes.APP),
            MenuItem(name: "Monterey Jack Cheese Quesadilla",
                description: "",
                options: [MenuOption(description: "Plain", price: 4.75)],
                addOns: [MenuOption(description: "Chicken", price: 0.75),
                    MenuOption(description: "Veggies", price: 0.75)],
                type: foodTypes.APP),
            
            // SALADS
            MenuItem(name: "Spinach & Feta Salad",
                description: "Fresh baby spinach with craisins, toasted walnuts, crumbled feta cheese, sliced apple & lemon poppy seed vinaigrette",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.SALAD),
            MenuItem(name: "Cobb Salad",
                description: "Romaine lettuce, chicken, crisp bacon, tomato, avocado, and egg with blue cheese",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                type: foodTypes.SALAD),
            MenuItem(name: "Magee's Garden Salad (VE)",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 2.25),
                    MenuOption(description: Options.LARGE, price: 3.75)],
                type: foodTypes.SALAD),
            MenuItem(name: "Jack's Caesar Salad",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 3.00),
                    MenuOption(description: Options.LARGE, price: 4.25)],
                type: foodTypes.SALAD),
            MenuItem(name: "Mandarin Almond Salad (V)",
                description: "Mixed lettuces with mandarin oranges, crisp noodles and slices almonds with Asain peanut dressing",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.00)],
                type: foodTypes.SALAD),
            MenuItem(name: "Greek Salad with Hummus (V)",
                description: "Romaine lettuce, cucumbers, cherry tomatoes, artichoke hearts, pepperoncini, red onion, feta cheese and kalamata olives with a side of hummus and warm pita",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                type: foodTypes.SALAD),
            
            // PANINIS
            MenuItem(name: "Chicken Pesto Panino",
                description: "Grilled chicken, pesto, roasted red peppers and mozzarella on an herbed ciabatta roll",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                type: foodTypes.PANINI),
            MenuItem(name: "Tuna Melt Panino",
                description: "Homemade tuna salad with melted American cheese on sliced Italian bread",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                type: foodTypes.PANINI),
            MenuItem(name: "Portobello & Goat Cheese Panino (V)",
                description: "Portobello mushrooms with goat cheese, roasted red peppers, spinach & balsamic vinaigrette on an herbed ciabatta roll",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                type: foodTypes.PANINI),
            
            // BASKETS
            MenuItem(name: "Chicken Finger Basket",
                description: "with French fries",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.BASKET),
            MenuItem(name: "Fish and Chip Basket",
                description: "Fried haddock with French fries and Tartar sauce",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.BASKET),
            
            // Cold Sandwiches
            
            // TODO only one bread choice
            
            MenuItem(name: "Jack's Deli Sandwich",
                description: "Turkey, Ham, Tuna or Chicken Salad on your choice of bread with lettuce & tomato",
                options: [MenuOption(description: "Turkey", price: 5.50),
                        MenuOption(description: "Ham", price: 5.50),
                        MenuOption(description: "Tuna", price: 5.50),
                        MenuOption(description: "Chicken Salad", price: 5.50)],
                addOns: [MenuOption(description: "American Cheese", price: 0.75),
                        MenuOption(description: "Swiss Cheese", price: 0.75),
                        MenuOption(description: "Cheddar Cheese", price: 0.75),
                        MenuOption(description: "White Bread", price: 0.00),
                        MenuOption(description: "Wheat Bread", price: 0.00),
                        MenuOption(description: "Rye Bread", price: 0.00),
                        MenuOption(description: "Sourdough", price: 0.00),
                        MenuOption(description: "Multi-grain Bread", price: 0.00),
                        MenuOption(description: "Wrap", price: 0.00),
                        MenuOption(description: "Ciabatta Roll", price: 0.50)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "Jack’s Double-Decker Turkey Club",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "BLT Sandwich",
                description: "On toasted white or wheat bread",
                options: [MenuOption(description: "White Bread", price: 4.25),
                            MenuOption(description: "Wheat Bread", price: 4.25)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "Veggie Flatbread (VE)",
                description: "Lettuce, tomato, cucumber, red onion, carrots, cabbage, avocado and dried cranberries in a grilled whole wheat flatbread with balsamic vinaigrette",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                type: foodTypes.COLD_SANDWICH),
            
            // Hot Sandwiches
            
            MenuItem(name: "Hamburger",
                description: "Freshly ground in our own meat shop",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.00)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Cheeseburger",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Turkey Burger",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Polar Bear Burger",
                description: "Our signature quarter pounder with grilled onions, mushrooms, bacon & Swiss cheese",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Smoke House Burger",
                description: "Choice of beef or turkey burger with Swiss cheese, bacon, crisp onion rings & BBQ sauce",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Blue Mango Garden Burger (VE)",
                description: "Locally made black bean & spinach veggie burger serverd on a bulkie roll with lettuce & tomato",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Shaved Philly Steak & Cheese",
                description: "Served with grilled onions and peppers on a toasted roll",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Flat Top Falafel with Tzatziki Sauce (V)",
                description: "Grilled falafel in our home-made pita with lettuce, tomato & tzatziki",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Chicken Parmesan Sandwich",
                description: "Deep fried chicken patty with marinara, mozarella and parmesan on a bulkie roll",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.75)],
                type: foodTypes.HOT_SANDWICH),
            MenuItem(name: "Classic Grilled Cheese Sandwich (V)",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 3.00)],
                type: foodTypes.HOT_SANDWICH),
            
            
            // BURRITOS & WRAPS
            MenuItem(name: "Fish Taco",
                description: "A flour tortilla filled with fried fish, shredded cabbage, avocado, Monterey jack cheese, salsa & green onion-mayo",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                type: foodTypes.WRAP),
            MenuItem(name: "Burrito \"El Grande\"",
                description: "A tortilla stuffed with yellow rice, jack cheese, onions, lettuce and tomatoes with your choice of grilled veggies (V), chicken or beef. Sour cream and salsa on the side",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                type: foodTypes.WRAP),
            MenuItem(name: "Chicken Caesar Wrap",
                description: "The classic wrap of romaine, parmesan cheese, croutons and Caesar dressing with sliced grilled chicken breast",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.25)],
                type: foodTypes.WRAP),
            MenuItem(name: "Buffalo Chicken & Blue Cheese Wrap",
                description: "Buffalo chicken strips, lettuce, tomato and blue cheese dressing in a flour tortilla",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.WRAP),
            MenuItem(name: "Cobb Salad Wrap",
                description: "A chopped salad in a flour tortilla: romaine lettuce, chicken, crisp bacon, tomato, avocado and egg with blue cheese dressing",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                type: foodTypes.WRAP),
            MenuItem(name: "Tandoori Tempeh Wrap (VE)",
                description: "Tandoori marinated tempeh with curried cauliflower, quinoa and spicy eggplant relish",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                type: foodTypes.WRAP),
            
            // PIZZAS
            MenuItem(name: "Basic Cheese Pizza (V)",
                description: "",
                options: [MenuOption(description: "10 inch", price: 5.50),
                    MenuOption(description: "16 inch", price: 8.95)],
                type: foodTypes.PIZZA),
            MenuItem(name: "BBQ Chicken Pizza",
                description: "Shredded chicken smothered in BBQ sauce with mozzarella cheese",
                options: [MenuOption(description: "10 inch", price: 7.00),
                    MenuOption(description: "16 inch", price: 13.00)],
                type: foodTypes.PIZZA),
            MenuItem(name: "Buffalo Chicken Pizza",
                description: "Chicken, mozzarella, blue cheese sauce and a squirt of red hot",
                options: [MenuOption(description: "10 inch", price: 7.00),
                    MenuOption(description: "16 inch", price: 13.00)],
                type: foodTypes.PIZZA),
            
            // CALZONES
            
            MenuItem(name: "Pesto Chicken Calzone",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.25)],
                type: foodTypes.CALZONE),
            MenuItem(name: "Buffalo Chicken Calzone",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 7.25)],
                type: foodTypes.CALZONE),
            MenuItem(name: "Cheese Calzone",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                type: foodTypes.CALZONE),
            
            // SIDES
            MenuItem(name: "French Fries",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 1.75),
                    MenuOption(description: Options.LARGE, price: 2.25)],
                type: foodTypes.SIDE),
            MenuItem(name: "Steak Fries",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 2.25),
                    MenuOption(description: Options.LARGE, price: 2.95)],
                type: foodTypes.SIDE),
            MenuItem(name: "Fajita Fries",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 1.75),
                    MenuOption(description: Options.LARGE, price: 2.25)],
                type: foodTypes.SIDE),
            MenuItem(name: "Onion Rings",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 1.75),
                    MenuOption(description: Options.LARGE, price: 2.50)],
                type: foodTypes.SIDE),
            MenuItem(name: "Sweet Potato Fries",
                description: "",
                options: [MenuOption(description: Options.SMALL, price: 2.25),
                    MenuOption(description: Options.LARGE, price: 2.95)],
                type: foodTypes.SIDE),
            MenuItem(name: "Guacomole",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.50)],
                type: foodTypes.SIDE),
            
            // BEVERAGES
            
            MenuItem(name: "Refillable Fountain Beverage",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.25)],
                type: foodTypes.BEVERAGE),
            MenuItem(name: "Pint of Milk",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.19)],
                type: foodTypes.BEVERAGE),
            MenuItem(name: "Coffee",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                type: foodTypes.BEVERAGE),
            MenuItem(name: "Tea",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.30)],
                type: foodTypes.BEVERAGE),
            MenuItem(name: "Fresh Brewed Iced Tea",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 1.20)],
                type: foodTypes.BEVERAGE)
        ]
        
        // TODO gluten free bread and pizza dough, pizza toppings prices
        
        for i in 0..<items.count {
            // all salads have these add ons
            if items[i].type == MenuItems.foodTypes.SALAD {
                items[i].addOns.append(MenuOption(description: "Grilled Chicken", price: 2.00))
                items[i].addOns.append(MenuOption(description: "Plain Chicken Finger", price: 1.00))
                items[i].addOns.append(MenuOption(description: "Buffalo Chicken Finger", price: 1.00))
                items[i].addOns.append(MenuOption(description: "Shaved Steak", price: 1.75))
            }
            
            // all sandwiches have these sides
            if items[i].type == MenuItems.foodTypes.COLD_SANDWICH || items[i].type == MenuItems.foodTypes.HOT_SANDWICH {
                items[i].sides.append(MenuOption(description: "baked potato chips", price: 0.00))
                items[i].sides.append(MenuOption(description: "side salad", price: 0.00))
                items[i].sides.append(MenuOption(description: "sliced fresh veggies", price: 0.00))
                items[i].sides.append(MenuOption(description: "sliced fresh fruit", price: 0.00))
                items[i].sides.append(MenuOption(description: "French fries", price: 1.00))
            }
            
            // TODO pricing these
            
            // all pizzas have these toppings
            if items[i].type == MenuItems.foodTypes.PIZZA || items[i].type == MenuItems.foodTypes.CALZONE {
                items[i].addOns = [MenuOption(description: "Pepperoni", price: 0.00), MenuOption(description: "Sausage", price: 0.00), MenuOption(description: "Ham", price: 0.00), MenuOption(description: "Ground Beed", price: 0.00), MenuOption(description: "Bacon", price: 0.00), MenuOption(description: "Chicken", price: 0.00), MenuOption(description: "Green Peppers", price: 0.00), MenuOption(description: "Roasted Red Peppers", price: 0.00), MenuOption(description: "Onions", price: 0.00), MenuOption(description: "Mushrooms", price: 0.00), MenuOption(description: "Artichoke Hearts", price: 0.00), MenuOption(description: "Tomato", price: 0.00), MenuOption(description: "Pineapple", price: 0.00), MenuOption(description: "Feta Cheese", price: 0.00), MenuOption(description: "Pesto", price: 0.00)]
            }
        }
        
        // group the menu by type
        for item in items {
            switch item.type {
            case foodTypes.APP: apps.append(item)
            case foodTypes.SALAD: salads.append(item)
            case foodTypes.PANINI: panini.append(item)
            case foodTypes.BASKET: baskets.append(item)
            case foodTypes.COLD_SANDWICH: coldSandwiches.append(item)
            case foodTypes.HOT_SANDWICH: hotSandwiches.append(item)
            case foodTypes.WRAP: wraps.append(item)
            case foodTypes.PIZZA: pizzas.append(item)
            case foodTypes.CALZONE: calzones.append(item)
            case foodTypes.SIDE: sides.append(item)
            case foodTypes.BEVERAGE: beverages.append(item)
            default: break
            }
        }
        
        menu = [apps, salads, panini, baskets, coldSandwiches, hotSandwiches, wraps, pizzas, calzones, sides, beverages]
    }
}

// MARK: - Menu items

class MenuItem {
    var name = ""
    var description = ""
    var options = [MenuOption]()
    var addOns = [MenuOption]()
    var sides = [MenuOption]()
    var type = ""
    
    // constructors
    
    init(name: String, description: String, options: [MenuOption], type: String) {
        self.name = name
        self.description = description
        self.options = options
        self.type = type
    }
    
    init(name: String, description: String, options: [MenuOption], addOns: [MenuOption], type: String) {
        self.name = name
        self.description = description
        self.options = options
        self.addOns = addOns
        self.type = type
    }
    
    init(name: String, description: String, options: [MenuOption], sides: [MenuOption], addOns: [MenuOption], type: String) {
        self.name = name
        self.description = description
        self.options = options
        self.sides = sides
        self.addOns = addOns
        self.type = type
    }
    
    init(otherMenuItem: MenuItem) {
        self.name = otherMenuItem.name
        self.description = otherMenuItem.description
        self.options = otherMenuItem.options
        self.addOns = otherMenuItem.addOns
        self.sides = otherMenuItem.sides
        self.type = otherMenuItem.type
    }
    
    init() {}
    
    // Turn an item into a string
    // Assumes that an order will only have 1 option and 1 side
    func asStringAndPrice() -> (string: String, price: Float) {
        var price: Float = 0.00
        
        if options.count == 0 { return (name, price) }
        
        var resultString = options[0].description + " " + name
        price += options[0].price
        
        if sides.count > 0 {
            resultString += " with " + sides[0].description
            price += sides[0].price
        }
            
        if addOns.count > 0 {
            resultString += " Add " + addOns[0].description
            price += addOns[0].price
            for i in 1..<addOns.count {
                resultString += ", Add " + addOns[i].description
                price += addOns[i].price
            }
        }
        return (resultString, price)
    }
}

// MARK: - Menu option

class MenuOption {
    var description: String = ""
    var price: Float = -1.0
    
    init(description: String, price: Float) {
        self.description = description
        self.price = price
    }
    
    init() {}
    
    func asString() -> String {
        if description != MenuItems.Options.NO_OPTIONS { return description + " " + price.asPriceString() }
        return price.asPriceString()
    }
}

// print prices with 2 decimal places
extension Float {
    func asPriceString() -> String {
        return "$" + String(format: "%.2f", self)
    }
}