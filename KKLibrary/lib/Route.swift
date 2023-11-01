//
//  Route.swift
//  KKLibrary
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

internal enum Route {
    case userInfo
    case friend(page: Int)
    
    internal var requestProperties: (method: HttpMethod, path: String) {
        switch self {
        case .userInfo:
            return (.GET, "/man.json")
        case let .friend(page):
            return (.GET, "friend\(page).json")
        }
    }
}
