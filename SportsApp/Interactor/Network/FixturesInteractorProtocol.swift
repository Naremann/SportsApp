//
//  FixturesInteractorProtocol.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import Foundation

protocol FixturesInteractorProtocol{
    func fetchDataOfFixtures(leagueKey : Int ,sport:Sport,completionHandler: @escaping(Result<[Fixture] , Error>) -> Void)
}
