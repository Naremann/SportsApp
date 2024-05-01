//
//  LeaguesResponse.swift
//  SportsApp
//
//  Created by Nareman on 30/04/2024.
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
    let logo_data:Data?
}
