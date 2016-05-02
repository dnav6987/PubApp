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

class NetworkConnection: NSObject, NSStreamDelegate {
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    var status = ""
    var delegate: NetworkConnectionDelegate!
    
    func connect(host: String, port: Int) {
        // set up the input and output streams with the server
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
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
    
    // delegate function that allows handling of sending and recieving data
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("input: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                
                // data was recieved, let's read it!
                
                // TODO recieve 2^12
                
                // Buffer to hold the data. All server messages are of length three characters
                var buffer = [UInt8](count: 3, repeatedValue: 0)
                inputStream!.read(&buffer, maxLength: buffer.count)
                
                // "rdy" is the server's message notifying that food is ready for pick up.
                // At this point in time we expect no other messages from the server
                if String(bytes: buffer, encoding: NSUTF8StringEncoding) == "rdy" {
                    if let otvc = delegate as? OrderTableViewController {
                        if let tbc = otvc.tabBarController {
                            // Present an alert message that the food is ready for pick up
                            tbc.selectedIndex = 1
                            delegate.alert("Ready For Pick Up", message: AlertMessages.RDY)
                            inputStream!.close()    // network communication stops when order is ready
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
