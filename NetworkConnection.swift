//
//  NetworkConnection.swift
//  PubApp
//
//  Created by Dan Navarro on 4/26/16.
//  Copyright © 2016 Dan Navarro. All rights reserved.
//

// TODO give stack overflow credit

import UIKit

class NetworkConnection: NSObject, NSStreamDelegate {
    struct StatusConstants {
        static let ERROR = "ERR"
        static let OPEN = "OPEN"
        static let SEND = "SEND"
        static let RCV = "RCV"
    }
    
    var host:String?
    var port:Int?
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    var status = ""
    
    func connect(host: String, port: Int) {
        
        self.host = host
        self.port = port
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self
            
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
                status = StatusConstants.ERROR
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
                status = StatusConstants.OPEN
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                status = StatusConstants.RCV
                                
            default:
                break
            }
        }
        else if aStream === outputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("output: ErrorOccurred: \(aStream.streamError?.description)")
                status = StatusConstants.ERROR
            case NSStreamEvent.OpenCompleted:
                print("output: OpenCompleted")
                status = StatusConstants.OPEN
            case NSStreamEvent.HasSpaceAvailable:
                print("output: HasSpaceAvailable")
                status = StatusConstants.SEND
                
            default:
                break
            }
        }
    }
    
    func close() {
        if inputStream != nil && outputStream != nil {
            inputStream?.close()
            outputStream?.close()
        }
    }
}
