//
//  TeamInteractor.swift
//  SportsApp
//
//  Created by Nareman on 26/04/2024.
//

import Foundation

protocol TeamInteractor{
    func fetchData(leagueId:Int,selectedSport:Sport,completionHandler: @escaping(Result<[Team] , Error>) -> Void)
    
}
