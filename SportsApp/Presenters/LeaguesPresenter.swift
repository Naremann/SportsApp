//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation

protocol LeaguesView{
    func showLeagues(leagues:[League])
    func showError(error:String)
}

protocol LeaguesPresenter{
    func getLeaguesFor(sport:Sport)
}
