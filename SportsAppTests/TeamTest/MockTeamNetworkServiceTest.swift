//
//  MockTeamNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//

import Foundation

import Foundation
import XCTest
@testable import SportsApp

class MockTeamNetworkServiceTest : XCTestCase{
    var mockService : MockTeamNetworkServices!
    
    
    override func setUpWithError() throws {
        mockService = MockTeamNetworkServices(shouldResultError: false)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testFetchDataFromJson(){
        mockService.fetchData(leagueId: 152, selectedSport: .football) { result in
            switch result{
            case .success(let teams):
                XCTAssertNotNil(teams)
            case .failure(_):
                XCTFail()
            }

        }
    }
}
    
  

