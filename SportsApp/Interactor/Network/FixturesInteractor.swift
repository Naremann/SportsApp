//
//  FixturesInteractor.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import Foundation
import Alamofire

class FixturesInteractor :FixturesInteractorProtocol{
    func fetchDataOfFixtures(leagueKey : Int ,sport: Sport, completionHandler: @escaping (Result<[Fixture], any Error>) -> Void) {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: nowDate)

        let calendar = Calendar.current
        var dateComponents = DateComponents(day: -3)
        let threeDaysAgo = calendar.date(byAdding: dateComponents, to: nowDate)
        let threeDaysAgoString = dateFormatter.string(from: threeDaysAgo!)

        let urlString = "\(Contants.BASE_URL)\(sport)/?met=Fixtures&APIkey=\(Contants.API_KEY)&from=\(threeDaysAgoString)&to=\(currentDateString)&leagueId=\(leagueKey)"
        print(urlString)
        AF.request(urlString).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    completionHandler(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                       let apiResponse = try decoder.decode(FixturesResponse.self, from: data)
                       let fixtures = apiResponse.result
                    completionHandler(.success(fixtures))
                } catch {
                    print("Error decoding JSON:", error)
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                print("Request failed with error:", error)
                completionHandler(.failure(error))
            }
        }
    }
}
