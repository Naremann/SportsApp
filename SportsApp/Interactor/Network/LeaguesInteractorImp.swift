//
//  LeaguesInteractorImp.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation
import Alamofire

class LeaguesInteractorImp:LeaguesInteractor{
    
    
    
    func fetchData(sport: Sport, completionHandler: @escaping(Result<[League], Error>) -> Void) {
        
        let urlString = "\(Contants.BASE_URL)\(sport)/?met=Leagues&APIkey=\(Contants.API_KEY)"
        
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
                       let apiResponse = try decoder.decode(LeaguesResponse.self, from: data)
                       let leagues = apiResponse.result
                    print("******************************")
                    for league in leagues {
//                            print("League Key:", league.league_key)
//                            print("League Name:", league.league_name ?? "N/A")
//                            print("League Logo:", league.league_logo ?? "N/A")
                        }
                    completionHandler(.success(leagues))
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
