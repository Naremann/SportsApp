//
//  MockNetworkServices.swift
//  SportsAppTests
//
//  Created by Nareman on 01/05/2024.
//


@testable import SportsApp
import Foundation

class MockNetworkServices {
    var shouldResultError: Bool

       init(shouldResultError: Bool) {
           self.shouldResultError = shouldResultError
       }
       
       let fakeJsonObj: [String: Any] = [
           "success": 1,
           "result": [
               [
                   "league_key": 4,
                   "league_name": "UEFA Europa League",
                   "country_key": 1,
                   "country_name": "eurocups",
                   "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                   "country_logo": nil
               ]
           ]
       ]

       func fetchLeagues(completionHandler: @escaping (LeaguesResponse?) -> Void) {
           if shouldResultError {
               completionHandler(nil)
               return
           }
           guard let jsonData = try? JSONSerialization.data(withJSONObject: fakeJsonObj) else {
               completionHandler(nil)
               return
           }

           do {
               let result = try JSONDecoder().decode(LeaguesResponse.self, from: jsonData)
               completionHandler(result)
           } catch {
               completionHandler(nil)
           }
       }
}
