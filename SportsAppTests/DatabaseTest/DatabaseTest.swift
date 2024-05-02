//
//  DatabaseTest.swift
//  SportsAppTests
//
//  Created by Mostfa Sobaih on 01/05/2024.
//

import XCTest
@testable import SportsApp

final class DatabaseTest: XCTestCase {

    var coreDataDatabase: CoreDataDatabase!
    
    override func setUpWithError() throws {
        coreDataDatabase = CoreDataDatabase()
    }

    override func tearDownWithError() throws {
        coreDataDatabase = nil
    }

    func testGetLeagues() {
        let league1 = League(league_key: 1, league_name: "League 1", league_logo: nil, logo_data: nil)
        let league2 = League(league_key: 2, league_name: "League 2", league_logo: nil, logo_data: nil)
        coreDataDatabase.saveLeagueItem(league: league1)
        coreDataDatabase.saveLeagueItem(league: league2)
        
        let fetchedLeagues = coreDataDatabase.getLeagues()
        XCTAssertNotNil(fetchedLeagues)
        XCTAssertTrue(fetchedLeagues.contains { $0.league_key == league1.league_key })
        XCTAssertTrue(fetchedLeagues.contains { $0.league_key == league2.league_key })
        coreDataDatabase.deleteLeagueItem(league: league1)
        coreDataDatabase.deleteLeagueItem(league: league2)
    }
    
    func testSaveLeagueItem() {
        let league = League(league_key: 1, league_name: "Test League", league_logo: nil, logo_data: nil)
        coreDataDatabase.saveLeagueItem(league: league)
        let savedLeagues = coreDataDatabase.getLeagues()
        XCTAssertTrue(savedLeagues.contains { $0.league_key == league.league_key })
        coreDataDatabase.deleteLeagueItem(league: league)
    }
    
    func testDeleteLeagueItem() {
        let league = League(league_key: 1, league_name: "Test League", league_logo: nil, logo_data: nil)
        coreDataDatabase.saveLeagueItem(league: league)
        coreDataDatabase.deleteLeagueItem(league: league)
        let savedLeagues = coreDataDatabase.getLeagues()
        XCTAssertFalse(savedLeagues.contains { $0.league_key == league.league_key })
    }

}
