//
//  FavoritesTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 5/2/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    typealias Favorite = (String, Int)
    
    var favorites = [String]()
    
    func refresh() {
        if Order.defaults.objectForKey(Order.FAVORITES_COUNTS) == nil {
            Order.defaults.setObject([String: Int](), forKey: Order.FAVORITES_COUNTS)
            Order.defaults.setObject([String: Float](), forKey: Order.FAVORITES_PRICES)
        }
        
        let favoritesDict = Order.defaults.objectForKey(Order.FAVORITES_COUNTS) as! [String: Int]
        var favoritesList = [Favorite]()
        
        for (fav, count) in favoritesDict { favoritesList.append((fav, count)) }
        
        favoritesList.sortInPlace {
            return $0.1 > $1.1
        }
        
        favorites = [String]()
        for fav in favoritesList {
            favorites.append(fav.0)
            
            if favorites.count >= 5 { break }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()   // refresh the data
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.count == 0 { return 1 }  // if there are none, still want one cell server warning
        return favorites.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavCell", forIndexPath: indexPath)
        cell.accessibilityIdentifier = "\(indexPath.row)"

        // if no favorites exist notify the user
        if favorites.count == 0 {
            cell.textLabel?.text = "Favorites will be updated once you place your first order"
            cell.detailTextLabel?.text = ""
        } else {
            // title = item, subtitle = name
            cell.textLabel?.text = favorites[indexPath.row]
            let prices = Order.defaults.objectForKey(Order.FAVORITES_PRICES) as! [String: Float]
            let thisPrice = prices[favorites[indexPath.row]]
            cell.detailTextLabel?.text = thisPrice?.asPriceString()
        }

        return cell
    }
    
    // MARK: - Segue
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // set the order and the prices
        
        let thisItem = favorites[Int((sender?.accessibilityIdentifier)!)!]
        
        if var order = Order.defaults.arrayForKey(Order.ORDER_STRING) as? [String] {
            order.append(thisItem)
            Order.defaults.setObject(order, forKey: Order.ORDER_STRING)
        }
        
        if var prices = Order.defaults.arrayForKey(Order.PRICES_STRING) as? [Float] {
            let favPrices = Order.defaults.objectForKey(Order.FAVORITES_PRICES) as! [String: Float]
            prices.append(favPrices[thisItem]!)
            Order.defaults.setObject(prices, forKey: Order.PRICES_STRING)
        }
        
        // segue to the order page, which has tab index 1
        if let tabCon = segue.destinationViewController as? UITabBarController {
            tabCon.selectedIndex = 1
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return favorites.count > 0
    }
}
