//
//  TeamsInteractorTests.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//


import XCTest
@testable import SportsApp


class TeamsInteractorTests : XCTestCase{
    var teamInteractor : TeamInteractor!
    override func setUpWithError() throws {
        teamInteractor = TeamInteractorImp()
    }
    
    override func tearDownWithError() throws {
        teamInteractor = nil
    }
    
    func testData(){
        let expectation = expectation(description: "Fetching teams")
        teamInteractor.fetchData(leagueId: 152, selectedSport: .football) { result in
            switch result{
            case .success(let teams):
                XCTAssertFalse(teams.isEmpty,"Teams are Empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching Teams failed with error: \(error)")

            }
        }
            
        waitForExpectations(timeout: 5)
    }
}

