//
//  KKServiceProtocol.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/10/31.
//

import Foundation

public protocol KKServiceProtocol {
    var serverConfig: ServerConfigType { get }
    
    init(serverConfig: ServerConfigType)
}
