//
//  TeamDetailsResponse.swift
//  SportsApp
//
//  Created by Nareman on 30/04/2024.
//

import Foundation

struct TeamDetailsResponse :Codable{
    let success: Int
    let result: [TeamDetails]
}

struct TeamDetails :Codable{
    let team_key : Int
    let team_name : String
    let team_logo : String?
}
