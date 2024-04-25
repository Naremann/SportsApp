//
//  SportsPresenter.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation


protocol SportsView{
    func showSports(sportItems:[SportItem])
    func navigateToLeaguesTableViewController(sport:Sport)
}

protocol SportsPresenter{
    func viewDidload()
    func numberOfSports()->Int
    func sportItemAt(Index:Int)->SportItem
    func didSelectedSportAt(index:Int)
}



