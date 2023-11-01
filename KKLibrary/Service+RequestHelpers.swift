//
//  Service+RequestHelpers.swift
//  KKLibrary
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

extension KKService {
    
    private static let session = URLSession(configuration: .default)
    
    func request<M: Decodable>(_ route: Route) async throws -> M {
        
        let properties = route.requestProperties
        
        guard let url = URL(string: properties.path, relativeTo: serverConfig.apiBaseUrl as URL) else {
            fatalError(
              "URL(string: \(properties.path), relativeToURL: \(serverConfig.apiBaseUrl)) == nil"
            )
        }
        
        monitor.didCreateRequest(path: properties.path)
        
        do {
            let (data, _) = try await KKService.session.data(from: url)
            monitor.didReceive(responseData: data)
            return try JSONDecoder().decode(M.self, from: data)
        } catch {
            monitor.didReceive(error: error)
            throw error
        }
    }
}
