//
//  KKService.swift
//  KKLibrary
//
//  Created by Bing Bing on 2023/10/31.
//

import Foundation

public struct KKService: KKServiceProtocol {
    
    public let serverConfig: ServerConfigType
    
    public init(serverConfig: ServerConfigType) {
        self.serverConfig = serverConfig
    }
}
