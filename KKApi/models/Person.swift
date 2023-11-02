//
//  Person.swift
//  KKLibrary
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

/**
 {
   "response": [
     {
       "name": "黃靖僑",
       "status": 0,
       "isTop": "0",
       "fid": "001",
       "updateDate": "20190801"
     },
     {
       "name": "翁勳儀",
       "status": 2,
       "isTop": "1",
       "fid": "002",
       "updateDate": "20190802"
     },
     {
       "name": "洪佳妤",
       "status": 1,
       "isTop": "0",
       "fid": "003",
       "updateDate": "20190804"
     },
     {
       "name": "梁立璇",
       "status": 1,
       "isTop": "0",
       "fid": "004",
       "updateDate": "20190801"
     },
     {
       "name": "梁立璇",
       "status": 1,
       "isTop": "0",
       "fid": "005",
       "updateDate": "20190804"
     }
   ]
 }
 */

struct PersonEnvelope: Decodable {
    
    let response: [Person]
}

public struct Person: Decodable, Equatable {
    
    public var name: String
    public var status: Int
    public var isTop: Bool
    public var fid: String
    public var updateDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name, status, isTop, fid, updateDate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(Int.self, forKey: .status)
        self.isTop = try container.decode(String.self, forKey: .isTop) as String == "1"
        self.fid = try container.decode(String.self, forKey: .fid)
        self.updateDate = try container.decode(String.self, forKey: .updateDate)
    }
}
