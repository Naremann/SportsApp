//
//  FavoriteLeaguesPresenterImpl.swift
//  SportsApp
//
//  Created by Nareman on 27/04/2024.
//

import Foundation

class FavoriteLeaguesPresenterImpl : FavoriteLeaguesPresenter{
    private var view: FavoriteLeaguesView?
       private let database: Database
       
       init(view: FavoriteLeaguesView, database: Database) {
           self.view = view
           self.database = database
       }
       
       func viewDidLoad() {
           let favoriteLeagues = database.getLeagues()
           view?.displayFavoriteLeagues(leagues: favoriteLeagues)
       }
    
    func deleteLeague(league : League){
        database.deleteLeagueItem(league: league)
    }
    
    
}
