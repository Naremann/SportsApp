//
//  LeaguesPresenterImp.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation

class LeaguesPresenterImp : LeaguesPresenter{
    var interactor : LeaguesInteractor?
    var leaguesView : LeaguesView?
    
    init(interactor: LeaguesInteractor, leaguesView: LeaguesView) {
        self.interactor = interactor
        self.leaguesView = leaguesView
    }
    
    func getLeaguesFor(sport: Sport){
        interactor?.fetchData(sport: sport, completionHandler: { [self] result in
            switch result {
            case .success(let leages):
                self.leaguesView?.showLeagues(leagues: leages)
            case .failure(let error):
                leaguesView?.showError(error: error.localizedDescription)
            }
        })
    }
    
    
}
