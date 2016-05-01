//
//  NetworkConnection.swift
//  PubApp
//
//  Created by Dan Navarro on 4/26/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

// TODO give stack overflow credit

import UIKit

protocol NetworkConnectionDelegate {
    func alert(title: String, message: String)
}

class NetworkConnection: NSObject, NSStreamDelegate {
    var host:String?
    var port:Int?
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    var status = ""
    var delegate: NetworkConnectionDelegate!
    
    func connect(host: String, port: Int) {
        self.host = host
        self.port = port
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            // Schedule
            inputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            outputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            
            // Open!
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("input: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                
                var buffer = [UInt8](count: 3, repeatedValue: 0)
                inputStream!.read(&buffer, maxLength: buffer.count)
                
                if String(bytes: buffer, encoding: NSUTF8StringEncoding) == "rdy" {
                    if let otvc = delegate as? OrderTableViewController {
                        if let tbc = otvc.tabBarController {
                            tbc.selectedIndex = 1
                            delegate.alert("Ready For Pick Up", message: AlertMessages.RDY)
                            inputStream!.close()
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
