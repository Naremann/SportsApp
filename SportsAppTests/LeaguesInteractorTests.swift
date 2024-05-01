//
//  LeaguesInteractorTests.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//

import XCTest

@testable import SportsApp

class LeaguesInteractorTests : XCTestCase{
    var leaguesInteractor : LeaguesInteractor!
    override func setUpWithError() throws {
        leaguesInteractor = LeaguesInteractorImp()
    }
    
    override func tearDownWithError() throws {
        leaguesInteractor = nil
    }
    
    func testData(){
        let expectation = expectation(description: "Fetching leagues Data")
        let sport:Sport = .football
        leaguesInteractor.fetchData(sport: sport) { result in
            switch result{
            case .success(let leagues):
                XCTAssertFalse(leagues.isEmpty,"Leagues are Empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching leagues failed with error: \(error)")

            }
        }
        waitForExpectations(timeout: 5)
    }
}
