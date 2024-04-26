//
//  TeamInteractorImp.swift
//  SportsApp
//
//  Created by Nareman on 26/04/2024.
//

import Foundation
import Alamofire

class TeamInteractorImp : TeamInteractor{
    func fetchData(leagueId: Int,selectedSport:Sport,completionHandler: @escaping (Result<[Team], Error>) -> Void) {
        
        let urlString = "\(Contants.BASE_URL)\(selectedSport)/?met=Teams&leagueId=\(leagueId)&APIkey=\(Contants.API_KEY)"
        
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
                       let apiResponse = try decoder.decode(TeamsResponse.self, from: data)
                    let teams = apiResponse.result
                    
                    completionHandler(.success(teams))
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
