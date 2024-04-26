//
//  LeaguesInteractor.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation
protocol LeaguesInteractor{
    func fetchData(sport:Sport,completionHandler: @escaping(Result<[League] , Error>) -> Void)
    
    
}
