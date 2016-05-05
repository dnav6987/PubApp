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
        if onBowdoinWiFi() {
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
        } else {
            inputStream = nil
            outputStream = nil
            print("Connection: not on Bowdoin Wifi")
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
                    var buffer = [UInt8](count: 4096, repeatedValue: 0)
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
    
    // determine if the device is on bowdoin Wifi using the fact that all bowdoin IP addresses start with 139.140
    private func onBowdoinWiFi() -> Bool {
        let bowdoinIPSpace = "139.140"
        
        let RUNNING_ON_SIMULATOR = runningOnSimulator()
        
        if RUNNING_ON_SIMULATOR {
            let deviceIPAddrs = getIFAddresses()
            if deviceIPAddrs.count > 0 {
                let deviceIPAddr = deviceIPAddrs[0]
                if deviceIPAddr.characters.count >= bowdoinIPSpace.characters.count {
                    if deviceIPAddr.substringToIndex(deviceIPAddr.startIndex.advancedBy(bowdoinIPSpace.characters.count)) == bowdoinIPSpace {
                        return true
                    }
                }
            }
        } else if let deviceIPAddr = getWiFiAddress() {
            if deviceIPAddr.characters.count >= bowdoinIPSpace.characters.count {
                if deviceIPAddr.substringToIndex(deviceIPAddr.startIndex.advancedBy(bowdoinIPSpace.characters.count)) == bowdoinIPSpace {
                    return true
                }
            }
        }
        
        return false
    }
    
    // Taken directly from http://stackoverflow.com/questions/30748480/swift-get-devices-ip-address
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    // NOTE: this only works on iPhones (and maybe other iOS devices)
    private func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr.memory.ifa_next }
                
                let interface = ptr.memory
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface.ifa_addr.memory.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    if let name = String.fromCString(interface.ifa_name) where name == "en0" {
                        
                        // Convert interface address to a human readable string:
                        var addr = interface.ifa_addr.memory
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        getnameinfo(&addr, socklen_t(interface.ifa_addr.memory.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String.fromCString(hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    // Taken directly from http://stackoverflow.com/questions/30748480/swift-get-devices-ip-address
    // return all IP addresses, this is for running on simulator and not on iPhone
    private func getIFAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr.memory.ifa_next }
                
                let flags = Int32(ptr.memory.ifa_flags)
                var addr = ptr.memory.ifa_addr.memory
                
                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String.fromCString(hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return addresses
    }
    
    // check if the device is running on a simulator or on an actual hardware device
    private func runningOnSimulator() -> Bool {
        var onSimulator = false
        #if arch(i386) || arch(x86_64)
            onSimulator = true
        #endif
        return onSimulator
    }
}