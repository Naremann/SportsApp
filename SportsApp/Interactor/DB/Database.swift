//
//  Database.swift
//  SportsApp
//
//  Created by Nareman on 26/04/2024.
//

import Foundation

protocol Database{
    func saveLeagueItem(league:League)
    func getLeagues()->[League]
    func deleteLeagueItem(league:League)
    
}
