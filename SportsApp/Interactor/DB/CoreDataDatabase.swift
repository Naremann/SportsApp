//
//  CoreDataDatabase.swift
//  SportsApp
//
//  Created by Nareman on 26/04/2024.
//

import Foundation
import UIKit
import CoreData

class CoreDataDatabase : Database{
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

  
    func saveLeagueItem(league: League) {
        let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: context)
        let leagueItem = NSManagedObject(entity: entity!, insertInto: context)
        leagueItem.setValue(league.league_key, forKey: "leagueKey")
        leagueItem.setValue(league.league_name, forKey: "leagueName")
        if let imageLogo = league.league_logo, let imageUrl = URL(string: imageLogo){
            do {
                let imageData = try Data(contentsOf: imageUrl)
                leagueItem.setValue(imageData, forKey: "league_logo")
                } catch {
                           print("Error downloading league logo: \(error)")
                }
            
        }
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func getLeagues() -> [League] {
        return []
    }
    
    func deleteLeagueItem(league: League) {
       

    }
    
    
}
