//
//  FixturesMocking.swift
//  SportsAppTests
//
//  Created by Mostfa Sobaih on 01/05/2024.
//

import Foundation
@testable import SportsApp

protocol FixturesMockingProtocol{
    func fetchDataOfFixtures(completionHandler: @escaping(Result<[Fixture] , Error>) -> Void)
}
class FixturesMocking : FixturesMockingProtocol{
    var isErrorFetching : Bool
    
    init(isErrorFetching: Bool) {
        self.isErrorFetching = isErrorFetching
    }
    
    enum ErrorResponse : Error {
        case error
    }
    
    let fakeFixturesJson: [String:Any] = ["success":1
                                                 ,"result":[
                                                    [
                                                        "league_key":205,
                                                        "event_date":"2024-05-01",
                                                        "event_time":"22:00",
                                                        "event_home_team":"Al-Masry",
                                                        "event_away_team":"Ismaily",
                                                        "home_team_logo":"Al-Masry Logo",
                                                        "away_team_logo":"Ismaily",
                                                        "event_ft_result":"0-0"
                                                    ]
                                                 ]
    ]
    
    func fetchDataOfFixtures(completionHandler: @escaping (Result<[SportsApp.Fixture], any Error>) -> Void) {
        var result : [Fixture]?
        do{
            var responseData = try JSONSerialization.data(withJSONObject: fakeFixturesJson)
            result = try JSONDecoder().decode([Fixture].self,from: responseData)
        }catch(let error){
            
        }
        if isErrorFetching {
            completionHandler(.success(result ?? []))
        }else{
            completionHandler(.failure(ErrorResponse.error))
        }
    }
    
    
}
