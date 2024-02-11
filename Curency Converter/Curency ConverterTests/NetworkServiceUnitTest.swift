//
//  NetworkServiceUnitTest.swift
//  Curency ConverterTests
//
//  Created by Никита Галкин on 2/10/24.
//

import XCTest
@testable import Curency_Converter

class NetworkServiceUnitTest: XCTestCase {
    var currencyAPI: NetworkService!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        currencyAPI = NetworkService()
    }
    
    override func tearDownWithError() throws {
        currencyAPI = nil
        try super.tearDownWithError()
    }
    
    func testGetStatus() async throws {
        let status = try await currencyAPI.getStatus()
        XCTAssertNotNil(status)
//        XCTAssertTrue(status.keys.contains("quotas"))
        // Add more specific assertions if needed
    }
    
    func testGetCurrencies() async throws {
        let currencies = try await currencyAPI.getCurrencies()
//        XCTAssertNotNil(currencies)
//        XCTAssertTrue(currencies.keys.contains("data"))
        // Add more specific assertions if needed
    }
    
    func testGetLatest() async throws {
        let latest = try await currencyAPI.getLatest()
        XCTAssertNotNil(latest)
//        XCTAssertTrue(latest.keys.contains("data"))
        // Add more specific assertions if needed
    }
}
