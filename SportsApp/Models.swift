//
//  Models.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 23/04/2024.
//

import Foundation

struct LeaguesResponse: Codable {
    let success: Int
    let result: [League]
}
struct League:Codable{
    let league_key: Int
    let league_name: String?
    let league_logo:String?
}
struct TeamsResponse:Codable{
    let success: Int
    let result: [Team]
}
struct Team: Codable{
    let team_key: Int
    let team_name: String
    let team_logo :String?
}
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
struct TeamDetailsResponse :Codable{
    let success: Int
    let result: [TeamDetails]
}
struct TeamDetails :Codable{
    let team_key : Int
    let team_name : String
    let team_logo : String?
}
