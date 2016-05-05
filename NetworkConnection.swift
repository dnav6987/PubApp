//
//  NetworkConnection.swift
//  PubApp
//
//  An implementation of http://stackoverflow.com/questions/28971858/nsstream-on-iphone-not-working
//  Comments by Dan Navarro

/*
    This is a generic network connection class that will communicate with a python server via a TCP socket
 */

import UIKit

// The connection will use alerts to notify the delegate when data has been recieved
protocol NetworkConnectionDelegate {
    func alert(title: String, message: String)
}

// IP address of the server
struct ServerAddress {
    static let HOST = "127.0.0.1"
    static let PORT = 5555
}

// The response codes from the server. All are 3 characters long
struct ServerResponses {
    static let RESPONSE_CODE_LENGTH = 3
    static let READY_FOR_PICK_UP = "rdy"
    static let RECIEVED_ORDER = "rcv"
    static let QUERY_RESPONSE = "qry"
    static let EMPTY_DATABASE = "emt"
}

class NetworkConnection: NSObject, NSStreamDelegate {
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    var status = ""
    var delegate: NetworkConnectionDelegate!
    
    func connect(host: String, port: Int) {
        // set up the input and output streams with the server
        autoreleasepool {
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        }
        
        if inputStream != nil && outputStream != nil {
            // if there is an error, set the streams nil so nobody tries to connect
            if inputStream!.streamError != nil || outputStream!.streamError != nil {
                inputStream = nil
                outputStream = nil
            } else {
                
                // This notifies when data is sent or recieved in the stream method
                inputStream!.delegate = self
                outputStream!.delegate = self
                
                // Schedule the streams
                inputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
                outputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
                
                // Open them for communication
                inputStream!.open()
                outputStream!.open()
            }
        }
    }
    
    // delegate function that allows handling of sending and recieving data
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("input: ErrorOccurred: \(aStream.streamError?.description)")
                inputStream = nil
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                
                // data was recieved, let's read it!
                
                // Buffer to hold the data
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    var buffer = [UInt8](count: 512, repeatedValue: 0)
                    self.inputStream!.read(&buffer, maxLength: buffer.count)
                    
                    var serverMessage = String(bytes: buffer, encoding: NSUTF8StringEncoding)

                    serverMessage = serverMessage!.stringByReplacingOccurrencesOfString("\0", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    if serverMessage != nil && serverMessage!.characters.count >= ServerResponses.RESPONSE_CODE_LENGTH {
                        let responseCode = serverMessage!.substringToIndex(serverMessage!.startIndex.advancedBy(ServerResponses.RESPONSE_CODE_LENGTH))

                        // handel the message from the server
                        switch responseCode {
                        case ServerResponses.READY_FOR_PICK_UP:
                            if let otvc = self.delegate as? OrderTableViewController {
                                if let tbc = otvc.tabBarController {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        // Present an alert message that the food is ready for pick up
                                        tbc.selectedIndex = 2
                                        self.delegate.alert("Ready For Pick Up", message: AlertMessages.RDY)
                                        self.inputStream!.close()    // network communication stops when order is ready
                                    }
                                }
                            }
                        case ServerResponses.RECIEVED_ORDER:
                            if let otvc = self.delegate as? OrderTableViewController {
                                if let tbc = otvc.tabBarController {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        // Present an alert message that the food is ready for pick up
                                        tbc.selectedIndex = 2
                                        self.delegate.alert("Sucess", message: AlertMessages.RCVD)
                                        self.inputStream!.close()
                                    }
                                }
                            }
                        case ServerResponses.EMPTY_DATABASE:
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate.alert("", message: ServerResponses.EMPTY_DATABASE)
                                self.inputStream!.close()    // network communication stops when order is ready
                            }
                        case ServerResponses.QUERY_RESPONSE:
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate.alert("", message: serverMessage!)
                                self.inputStream!.close()
                            }
                        default: break
                        }
                    }
                }
                
            default:
                break
            }
        }
        else if aStream === outputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("output: ErrorOccurred: \(aStream.streamError?.description)")
                outputStream = nil
            case NSStreamEvent.OpenCompleted:
                print("output: OpenCompleted")
            case NSStreamEvent.HasSpaceAvailable:
                print("output: HasSpaceAvailable")
                
            default:
                break
            }
        }
    }
}