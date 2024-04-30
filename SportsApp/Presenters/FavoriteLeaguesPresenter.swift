//
//  FavoriteLeaguesPresenter.swift
//  SportsApp
//
//  Created by Nareman on 27/04/2024.
//

import Foundation

protocol FavoriteLeaguesView {
    func displayFavoriteLeagues(leagues: [League])
}

protocol FavoriteLeaguesPresenter {
    func viewDidLoad()
    func deleteLeague(league : League)
}
