//
//  User.swift
//  KKLibrary
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

/**
 {
   "response": [
     {
       "name": "蔡國泰",
       "kokoid": "Mike"
     }
   ]
 }
 */
public struct UserEnvelope: Decodable {
    
    public let users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case users = "response"
    }
}

public struct User: Codable, Equatable {
    
    public var name: String
    public var kokoID: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case kokoID = "kokoid"
    }
}
