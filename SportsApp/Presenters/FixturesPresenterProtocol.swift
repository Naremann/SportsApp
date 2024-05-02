//
//  FixturesPresenterProtocol.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import Foundation

protocol TeamsView{
    func showTeams(teams:[Team])
    func showError(error:String)
}


protocol FixturesPresenterProtocol{
    func getFixturesFor(leagueKey:Int,sport:Sport)
    func getTeamsFor(leagueKey:Int,sport:Sport)

}
