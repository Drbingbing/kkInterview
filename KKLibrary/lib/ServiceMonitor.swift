//
//  ServiceMonitor.swift
//  KKLibrary
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation
import os.log

public protocol ServiceMonitor {
    
    var queue: DispatchQueue { get }
    
    func didCreateRequest(path: String)
    func didReceive(responseData: Data)
    func didReceive(error: Error)
}

public extension ServiceMonitor {
    
    func didCreateRequest(path: String) {}
    func didReceive(responseData: Data) {}
    func didReceive(error: Error) {}
}

public final class CompositeServiceMonitor: ServiceMonitor {
    
    public let queue: DispatchQueue = DispatchQueue(label: "com.kkinterview.tw.compositeServiceMonitor", qos: .utility)
    
    let monitors: [ServiceMonitor]
    
    public init(monitors: [ServiceMonitor]) {
        self.monitors = monitors
    }
    
    private func performEvent(_ event: @escaping (ServiceMonitor) -> Void) {
        queue.async {
            for monitor in self.monitors {
                monitor.queue.async { event(monitor) }
            }
        }
    }
    
    public func didCreateRequest(path: String) {
        performEvent { $0.didCreateRequest(path: path) }
    }
    
    public func didReceive(responseData: Data) {
        performEvent { $0.didReceive(responseData: responseData) }
    }
    
    public func didReceive(error: Error) {
        performEvent { $0.didReceive(error: error) }
    }
}

public final class KKServiceMonitor: ServiceMonitor {
    
    public let queue: DispatchQueue = DispatchQueue(label: "com.kkinterview.tw.KKServiceMonitor", qos: .utility)
    private let pointOfInterest = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: .pointsOfInterest)
    
    public init() {}
    
    public func didCreateRequest(path: String) {
        log("Creating request. path: \(path)")
        os_signpost(.begin, log: pointOfInterest, name: "kkservice", signpostID: OSSignpostID(log: pointOfInterest))
    }
    
    public func didReceive(responseData: Data) {
        os_signpost(.end, log: pointOfInterest, name: "kkservice", signpostID: OSSignpostID(log: pointOfInterest))
        let string = String(data: responseData, encoding: .utf8)
        log(string ?? "response")
    }
    
    public func didReceive(error: Error) {
        os_signpost(.end, log: pointOfInterest, name: "kkservice", signpostID: OSSignpostID(log: pointOfInterest))
        log(error.localizedDescription)
    }
    
    private func log(_ message: String) {
        #if DEBUG
        print("🔖[KKService] \(message)")
        #endif
    }
}
