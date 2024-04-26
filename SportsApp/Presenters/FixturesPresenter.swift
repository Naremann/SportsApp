//
//  FixturesPresenter.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import Foundation

class FixturesPresenter : FixturesPresenterProtocol{
    var interactor : FixturesInteractorProtocol?
    var fixturesView : FixturesViewProtocol?
    
    init(interactor: FixturesInteractorProtocol, fixturesView: FixturesViewProtocol) {
        self.interactor = interactor
        self.fixturesView = fixturesView
    }
    
    
    
    func getFixturesFor(leagueKey: Int ,sport: Sport) {
        interactor?.fetchDataOfFixtures(leagueKey:leagueKey, sport: sport, completionHandler: { [self] result in
            switch result {
            case .success(let fixtures):
                self.fixturesView?.showLeagues(fixtures: fixtures)
            case .failure(let error):
                fixturesView?.showError(error: error.localizedDescription)
            }
        })
    }
    
    
}
