//
//  FixturesMockingTest.swift
//  SportsAppTests
//
//  Created by Mostfa Sobaih on 01/05/2024.
//

import XCTest
@testable import SportsApp

final class FixturesMockingTest: XCTestCase {
    
    var fixtureMockingSuccess : FixturesMockingProtocol?
    var fixtureMockingFailure : FixturesMockingProtocol?

    override func setUpWithError() throws {
        fixtureMockingSuccess = FixturesMocking(isErrorFetching: true)
        fixtureMockingFailure = FixturesMocking(isErrorFetching: false)
    }

    override func tearDownWithError() throws {
        fixtureMockingSuccess = nil
        fixtureMockingFailure = nil
    }

    func testMockingSuccess() throws {
        fixtureMockingSuccess?.fetchDataOfFixtures { res in
            switch res {
            case .success(let success):
                XCTAssertNotNil(success)
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testMockingFailure() throws {
        fixtureMockingFailure?.fetchDataOfFixtures { res in
            switch res {
            case .success(let success):
                XCTAssertNotNil(success)
            case .failure(_):
                XCTFail()
            }
        }
    }

}
