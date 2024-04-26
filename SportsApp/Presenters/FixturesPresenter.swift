//
//  FixturesPresenter.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import Foundation

class FixturesPresenter : FixturesPresenterProtocol{
    
    var interactor : FixturesInteractorProtocol?
    var teamInteractor : TeamInteractor?
    var fixturesView : FixturesViewProtocol?
    var teamsView : TeamsView?
    
    init(interactor: FixturesInteractorProtocol,teamInteractor:TeamInteractor , fixturesView: FixturesViewProtocol,teamsView:TeamsView) {
        self.interactor = interactor
        self.teamInteractor = teamInteractor
        self.fixturesView = fixturesView
        self.teamsView = teamsView
    }
    
    
    
    func getTeamsFor(leagueKey: Int, sport: Sport) {
        
        teamInteractor?.fetchData(leagueId: leagueKey, selectedSport: sport, completionHandler: { [self] result in
            switch result {
            case .success(let teams):
                self.teamsView?.showTeams(teams: teams)
            case .failure(let error):
                 teamsView?.showError(error: error.localizedDescription)
            }
            
        })
                                  
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
