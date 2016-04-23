//
//  MenuItems.swift
//  PubApp
//
//  Created by Dan Navarro on 4/18/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import Foundation

class MenuItems {
    var items = [MenuItem]()
    // TODO rethink this
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
    
    struct Options {
        static let NO_OPTIONS = "Regular"
        static let SMALL = "Small"
        static let LARGE = "Large"
    }
    
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
            MenuItem(name: "Garlic - Herb Breadsticks with Marinara Sauce",
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
                options: [MenuOption(description: "Plain", price: 4.75),
                    MenuOption(description: "Add Veggies", price: 5.50),
                    MenuOption(description: "Add Chicken", price: 5.50)],
                type: foodTypes.APP),
            
            // SALADS
            // TODO make add ons for salads
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
            MenuItem(name: "Jack's Casear Salad",
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
            MenuItem(name: "Chicken Pesto PAnino",
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
                description: "Chicken Finger Basket with French fries",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.BASKET),
            MenuItem(name: "Fish and Chip Basket",
                description: "Fish and Chip Basket: Fried haddock with French fries and Tartar sauce",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.BASKET),
            
            // Cold Sandwiches
            
            MenuItem(name: "Jack's Deli Sandwich",
                description: "TODO need to work on this stull",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.50)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "Jack’s Double-Decker Turkey Club",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.75)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "BLT Sandwich",
                description: "On toasted white or wheat bread", // TODO
                options: [MenuOption(description: Options.NO_OPTIONS, price: 4.25)],
                type: foodTypes.COLD_SANDWICH),
            MenuItem(name: "Veggie Flatbread (VE)",
                description: "Lettuce, tomato, cucumber, red onion, carrots, cabbage, avocado and dried cranberries in a grilled whole wheat  atbread with balsamic vinaigrette",
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
            MenuItem(name: "Classic Grilled Cheesesandwich (V)",
                description: "",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 3.00)],
                type: foodTypes.HOT_SANDWICH),
            
            
            // BURRITOS & WRAPS
            MenuItem(name: "Fish Taco",
                description: "A  our tortilla filled with fried fish, shredded cabbage, avocado, Monterey jack cheese, salsa & green onion-mayo",
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
                description: "Buffalo chicken strips, lettuce, tomato and blue cheese dressing in a  our tortilla",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 6.50)],
                type: foodTypes.WRAP),
            MenuItem(name: "Cobb Salad Wrap",
                description: "A chopped salad in a  our tortilla: romaine lettuce, chicken, crisp bacon, tomato, avocado and egg with blue cheese dressing",
                options: [MenuOption(description: Options.NO_OPTIONS, price: 5.95)],
                type: foodTypes.WRAP),
            MenuItem(name: "Tandoori Tempeh Wrap (VE)",
                description: "Tandoori marinated tempeh with curried cauli ower, quinoa and spicy eggplant relish",
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
                    MenuOption(description: Options.LARGE, price: 2.75)],
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
        
        // TODO gluten free bread and pizza dough, pizza toppings add (V) and (VE), add ons and additional options in a drop down menu maybe
        
        
        
        // TODO rethink this
        for item in items { if item.type == MenuItems.foodTypes.APP { apps.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.SALAD { salads.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.PANINI { panini.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.BASKET { baskets.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.COLD_SANDWICH { coldSandwiches.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.HOT_SANDWICH { hotSandwiches.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.WRAP { wraps.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.PIZZA { pizzas.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.CALZONE { calzones.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.SIDE { sides.append(item) } }
        for item in items { if item.type == MenuItems.foodTypes.BEVERAGE { beverages.append(item) } }
        
        menu = [apps, salads, panini, baskets, coldSandwiches, hotSandwiches, wraps, pizzas, calzones, sides, beverages]
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