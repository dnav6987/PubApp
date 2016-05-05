//
//  OrderFeedTableViewController.swift
//  PubApp
//
//  Created by Dan Navarro on 5/2/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

/*
    Display the most recent orders. Orders found by queerying the server. Results can be filtered by name
*/

// lets connect earlier

import UIKit

class OrderFeedTableViewController: UITableViewController, UITextFieldDelegate, NetworkConnectionDelegate {
    // list of the orders in the feed (item_name, customer_name)
    var orders = [(String, String)]() {
        didSet { tableView.reloadData() }
    }
    
    // the network connection
    var connection = NetworkConnection()
    
    // this allows the user to filter the search results to a specific person
    var searchText: String? {
        didSet {
            searchTextField?.text = searchText
            refresh()
        }
    }
    
    // the filter text field
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    // TODO necessary?
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text!
        }
        return true
    }
    
    // refresh
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl!)
    }
    
    // refresh the data. queery the server and see parse it's response
    @IBAction func refresh(sender: UIRefreshControl) {
        if self.connection.outputStream != nil && self.connection.inputStream != nil {
            // wait for response in a different thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // connect to server
                self.connection.connect(ServerAddress.HOST, port: ServerAddress.PORT)
                
                if self.searchText == nil {
                    self.connection.outputStream!.write(ServerResponses.QUERY_RESPONSE, maxLength: ServerResponses.QUERY_RESPONSE.characters.count)    // send queery response
                } else {
                    let qryString = ServerResponses.QUERY_RESPONSE + (self.searchText == "" ? "" : " " + self.searchText!) // "qry <name>"
                    self.connection.outputStream!.write(qryString, maxLength: qryString.characters.count)    // send queery response
                }
                self.connection.outputStream!.close()
                
                let start = NSDate()    // time at which the connection started (too track wait time)
                
                while true {    // I know, I know, this is dangerous... but living on the edge (and a gauruntee that a timer will break out of the loop)
                    if self.connection.inputStream!.hasBytesAvailable {
                        // Wait for confirmation that the server recieved the order. If timer runsout, assume the data was lost
                        
                        // see if the server has sent data back
                        var buffer = [UInt8](count: 512, repeatedValue: 0)
                        self.connection.inputStream!.read(&buffer, maxLength: buffer.count)
                        
                        // convert the data to a string
                        let dataString = String(bytes: buffer, encoding: NSUTF8StringEncoding)
                        
                        if dataString != nil {
                            // get ride of all of the null characters from the buffer
                            let serverMessage = dataString!.stringByReplacingOccurrencesOfString("\0", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            
                            // check if the begining characters are the correct response code
                            if serverMessage.characters.count >= ServerResponses.RESPONSE_CODE_LENGTH && serverMessage.substringToIndex(serverMessage.startIndex.advancedBy(ServerResponses.RESPONSE_CODE_LENGTH)) == ServerResponses.QUERY_RESPONSE {
                                self.connection.inputStream!.close()
                                dispatch_async(dispatch_get_main_queue()) {
                                    // parse the response
                                    self.parseQueeryResponse(serverMessage)
                                    sender.endRefreshing()
                                }
                                break
                            } else if serverMessage.characters.count >= ServerResponses.RESPONSE_CODE_LENGTH && serverMessage.substringToIndex(serverMessage.startIndex.advancedBy(ServerResponses.RESPONSE_CODE_LENGTH)) == ServerResponses.EMPTY_DATABASE {
                                self.connection.inputStream!.close()
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.orders = [(String, String)]()
                                    sender.endRefreshing()
                                }
                                break
                            }
                        }
                    }
                    
                    else  if NSDate().timeIntervalSinceDate(start) >= 8 { // if this amount of time (in seconds) is exceeded assume the data is lost
                        self.connection.inputStream!.close()
                        dispatch_async(dispatch_get_main_queue()) {
                            self.orders = [(String, String)]()
                            sender.endRefreshing()
                        }
                        break
                    }
                }
            }
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                sender.endRefreshing()
            }
        }
    }
    
    // parse the queery response and store it in orders.
    // response format is qry;name:item;name:item;name:item;...
    func parseQueeryResponse(response: String) {
        var result = [(String, String)]()
        
        let eachOrder = response.characters.split{$0 == ";"}.map(String.init)
        
        for orderIndex in 1..<eachOrder.count {
            let nameAndItem = eachOrder[orderIndex].characters.split{$0 == ":"}.map(String.init)
            result.append((nameAndItem[1], nameAndItem[0]))
        }
        orders = result
    }
    
    func alert(title: String, message: String) {
        if self.refreshControl != nil {
            self.refreshControl?.endRefreshing()
        }
        
        if message != ServerResponses.EMPTY_DATABASE {
            self.parseQueeryResponse(message)
        } else {
            self.orders = [(String, String)]()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection.delegate = self
        searchText = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.connection.connect(ServerAddress.HOST, port: ServerAddress.PORT) // connect to the server (may be redundant but it is a good chance to try to reconnect if it was previously down)
            dispatch_async(dispatch_get_main_queue()) {
                self.refresh()
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orders.count == 0 { return 1 }  // if there are none, still want one cell server warning
        return orders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath)
        
        // if nothing could be retrieved notify the user
        if orders.count == 0 {
            cell.textLabel?.text = "Server could not be reached or there are no recent orders. Pull to refresh."
            cell.detailTextLabel?.text = ""
        } else {
            // title = item, subtitle = name
            cell.textLabel?.text = orders[indexPath.row].0
            cell.detailTextLabel?.text = orders[indexPath.row].1
        }
        
        return cell
    }
}
