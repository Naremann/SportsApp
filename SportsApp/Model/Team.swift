//
//  Player.swift
//  SportsApp
//
//  Created by Nareman on 30/04/2024.
//

import Foundation

struct TeamsResponse:Codable{
    let success: Int
    let result: [Team]
}

struct Team: Codable{
    let team_key: Int
    let team_name: String
    let team_logo :String?
    let players : [Player]?
    let coaches : [Coach]?
}

struct Player : Codable{
    let player_image : String?
    let player_name : String?
    let player_type : String?
    let player_number : String?
    let player_rating : String?
}
struct Coach : Codable{
    let coach_name :String
}
