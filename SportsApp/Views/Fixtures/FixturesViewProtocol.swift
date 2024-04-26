//
//  FixturesViewProtocol.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import Foundation

protocol FixturesViewProtocol{
    func showLeagues(fixtures:[Fixture])
    func showError(error:String)
}
