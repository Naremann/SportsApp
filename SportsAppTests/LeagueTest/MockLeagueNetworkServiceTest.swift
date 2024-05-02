//
//  MockNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//

import Foundation
import XCTest
@testable import SportsApp

class MockLeagueNetworkServiceTest : XCTestCase{
    var mockService : MockLeagueNetworkServices!

    
    override func setUpWithError() throws {
        mockService = MockLeagueNetworkServices(shouldResultError: false)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testFetchDataFromJson(){
        mockService.fetchData(sport: .football) { result in
            switch result{
            case .success(let leagues):
                XCTAssertNotNil(leagues)
            case .failure(_):
                XCTFail()
            }
    
        }
    }
    
  

}
