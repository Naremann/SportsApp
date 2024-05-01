//
//  FixturesInteractorTests.swift
//  SportsAppTests
//
//  Created by Mostfa Sobaih on 01/05/2024.
//

import XCTest
@testable import SportsApp

final class FixturesInteractorTests: XCTestCase {
    
    var fixtureInteractor : FixturesInteractorProtocol?

    override func setUpWithError() throws {
       fixtureInteractor = FixturesInteractor()
    }

    override func tearDownWithError() throws {
        fixtureInteractor = nil
    }

    func testFixturesSuccess() throws {
        let myExpectation = expectation(description: "Waiting Data---")
        fixtureInteractor?.fetchDataOfFixtures(leagueKey: 175, sport: .football) { res in
            
            switch res {
            case .success(let fixtures):
                XCTAssert(fixtures.count > 0,"Result failure")
                myExpectation.fulfill()
            case .failure(let error):
                XCTFail("No Data")
            }
        }
        
        waitForExpectations(timeout: 10)
    }

    func testFixturesFailure() throws {
        let myExpectation = expectation(description: "Waiting Data---")
        fixtureInteractor?.fetchDataOfFixtures(leagueKey: 76678238723723, sport: .football) { res in
            
            switch res {
            case .success(let fixtures):
                XCTAssert(fixtures.count > 0,"Result failure")
                myExpectation.fulfill()
            case .failure(let error):
                XCTFail("No Data")
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
}
