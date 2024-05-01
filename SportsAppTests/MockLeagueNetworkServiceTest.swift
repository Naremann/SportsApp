//
//  MockNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//

import Foundation
import XCTest
@testable import SportsApp

class MockNetworkServiceTest:XCTestCase{
    var mockNetworkServices : MockNetworkServices!
    
    override func setUpWithError() throws {
        mockNetworkServices = MockNetworkServices(shouldResultError: false)
    }
    
    override func tearDownWithError() throws {
        
    }
    
   

}
