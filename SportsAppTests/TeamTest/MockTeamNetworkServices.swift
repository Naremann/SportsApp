//
//  MockTeamNetworkServices.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//

import Foundation


@testable import SportsApp
import Foundation

class MockTeamNetworkServices {
    var shouldResultError: Bool

       init(shouldResultError: Bool) {
           self.shouldResultError = shouldResultError
       }
       
    let fakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "team_key": 80,
                "team_name": "Manchester City",
                "team_logo": "https://apiv2.allsportsapi.com/logo/80_manchester-city.jpg",
                "players": [
                    [
                        "player_key": 1226924072,
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/8433_s-ortega.jpg",
                        "player_name": "S. Ortega",
                        "player_number": "18",
                        "player_country": nil,
                        "player_type": "Goalkeepers",
                        "player_age": "31",
                        "player_match_played": "6",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_injured": "No",
                        "player_substitute_out": "0",
                        "player_substitutes_on_bench": "28",
                        "player_assists": "0",
                        "player_birthdate": "1992-11-06",
                        "player_is_captain": "0",
                        "player_shots_total": "",
                        "player_goals_conceded": "6",
                        "player_fouls_committed": "",
                        "player_tackles": "",
                        "player_blocks": "",
                        "player_crosses_total": "",
                        "player_interceptions": "",
                        "player_clearances": "2",
                        "player_dispossesed": "",
                        "player_saves": "15",
                        "player_inside_box_saves": "11",
                        "player_duels_total": "2",
                        "player_duels_won": "2",
                        "player_dribble_attempts": "",
                        "player_dribble_succ": "",
                        "player_pen_comm": "",
                        "player_pen_won": "",
                        "player_pen_scored": "0",
                        "player_pen_missed": "0",
                        "player_passes": "193",
                        "player_passes_accuracy": "151",
                        "player_key_passes": "",
                        "player_woordworks": "",
                        "player_rating": "7.01"
                    ]
                ]
            ]
        ]
    ]

    
    

  
}
extension MockTeamNetworkServices{
    func fetchData(leagueId: Int,selectedSport:Sport,completionHandler: @escaping (Result<[Team], Error>) -> Void) {
           if shouldResultError {
               completionHandler(.failure(ResponseWithError.responserError))
               return
           }
           guard let jsonData = try? JSONSerialization.data(withJSONObject: fakeJsonObj) else {
               completionHandler(.failure(ResponseWithError.responserError))
               return
           }

           do {
               let result = try JSONDecoder().decode(TeamsResponse.self, from: jsonData)
               completionHandler(.success(result.result))
           } catch let error{
               completionHandler(.failure(error))
           }
       }
}
