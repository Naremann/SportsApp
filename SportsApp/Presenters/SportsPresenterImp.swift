//
//  SportsPresenterImp.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation

class SportsPresenterImp : SportsPresenter{
    
    
    var sports : [SportItem] = []
    var sportsView : SportsView?
    
    
    init(sportsView: SportsView) {
        self.sportsView = sportsView
    }
    
    func didSelectedSportAt(index: Int) {
        let selectedSport = sports[index].sportKey
        sportsView?.navigateToLeaguesTableViewController(sport: selectedSport)
    }
    
    
    
    private func getSportsData() -> [SportItem]{
        let sports =  [SportItem(sportImage: "football",sportTitle: "Football",sportKey: .football),
                       SportItem(sportImage: "basketball",sportTitle: "BasketBall", sportKey: .basketball),
                       SportItem(sportImage: "cricket",sportTitle: "Cricket", sportKey: .cricket),
                       SportItem(sportImage: "tennis",sportTitle: "Tennis", sportKey: .tennis)]
        return sports
    }
    
    func viewDidload() {
        self.sports = getSportsData()
        sportsView?.showSports(sportItems: self.sports)
    }
    
    func numberOfSports() -> Int {
        sports.count
    }
    
    func sportItemAt(Index: Int) -> SportItem {
        return sports[Index]
    }
    
    
}
