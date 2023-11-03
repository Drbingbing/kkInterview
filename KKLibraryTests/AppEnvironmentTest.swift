//
//  AppEnvironmentTest.swift
//  KKLibraryTests
//
//  Created by 鍾秉辰 on 2023/11/3.
//

import XCTest
import KKApi
@testable import KKLibrary

final class AppEnvironmentTest: XCTestCase {
    
    func testUpdateServerConfig() {
        AppEnvironment.pushEnvironment()
        
        XCTAssertEqual(
            AppEnvironment.current.apiService.serverConfig.apiBaseUrl,
            ServerConfig.production.apiBaseUrl
        )
        
        let serverConfig = ServerConfig.development
        
        AppEnvironment.updateServerConfig(serverConfig)
        
        XCTAssertEqual(
            AppEnvironment.current.apiService.serverConfig.apiBaseUrl,
            ServerConfig.development.apiBaseUrl
        )
    }

    func testPushAndPopEnvironment() {
        
        let config = AppEnvironment.current.apiService.serverConfig
        
        AppEnvironment.pushEnvironment()
        
        XCTAssertEqual(config.apiBaseUrl, AppEnvironment.current.apiService.serverConfig.apiBaseUrl)
        
        let service = KKService(serverConfig: ServerConfig.development)
        AppEnvironment.pushEnvironment(apiService: service)
        XCTAssertEqual(service.serverConfig.apiBaseUrl, AppEnvironment.current.apiService.serverConfig.apiBaseUrl)
        
        let service2 = KKService()
        AppEnvironment.pushEnvironment(Environment(apiService: service2))
        XCTAssertEqual(service2.serverConfig.apiBaseUrl, AppEnvironment.current.apiService.serverConfig.apiBaseUrl)
        
        AppEnvironment.popEnvironment()
        XCTAssertEqual(service.serverConfig.apiBaseUrl, AppEnvironment.current.apiService.serverConfig.apiBaseUrl)
        
        AppEnvironment.popEnvironment()
        XCTAssertEqual(config.apiBaseUrl, AppEnvironment.current.apiService.serverConfig.apiBaseUrl)
        
        AppEnvironment.popEnvironment()
    }

}
