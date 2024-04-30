//
//  FixturesResponse.swift
//  SportsApp
//
//  Created by Nareman on 30/04/2024.
//

import Foundation

struct FixturesResponse:Codable{
    let success: Int
    let result: [Fixture]
}

struct Fixture:Codable{
    let league_key : Int
    let event_date :String
    let event_time :String
    let event_home_team :String
    let event_away_team :String
    let event_ft_result : String?
    let home_team_logo : String?
    let away_team_logo : String?
}
