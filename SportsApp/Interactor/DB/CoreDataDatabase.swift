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
    
    
    private func saveToContext() {
        do {
            try context.save()
            print("League item saved successfully")
        } catch {
            print("Error saving league item: \(error)")
        }
    }
    func saveLeagueItem(league: League) {
        let leagueEntity = LeagueEntity(context: context)
        leagueEntity.leagueKey = Int32(league.league_key) as? NSDecimalNumber
        leagueEntity.leagueName = league.league_name
        
        if let logoURLString = league.league_logo, let logoURL = URL(string: logoURLString) {
            downloadLogo(from: logoURL) { imageData in
                leagueEntity.league_logo = imageData
                self.saveToContext()
            }
        } else {
            saveToContext()
        }
    }
    
    
    func getLeagues() -> [League] {
        var leagues: [League] = []
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        
        
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: context)
        
        do {
               let fetchedLeagues = try context.fetch(fetchRequest) as! [LeagueEntity]
               
            for leagueEntity in fetchedLeagues {
                if let leagueName = leagueEntity.leagueName {
                    
                    let leagueKey = Int(leagueEntity.leagueKey ?? 0)
                    var logoURLString: String?
                    
                    if let logoData = leagueEntity.league_logo {
                        logoURLString = String(data: logoData, encoding: .utf8)
                    }
                    
                    let league = League(league_key: leagueKey, league_name: leagueName, league_logo: logoURLString, logo_data: leagueEntity.league_logo)
                    leagues.append(league)
                }
            }

         } catch {
         print("Error fetching leagues: \(error)")
         }
         
         return leagues
      
    }

    
    
    private func downloadLogo(from url: URL, completion: @escaping (Data) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error downloading league logo: \(error)")
                    return
                }
                
                guard let imageData = data else {
                    print("No data received")
                    return
                }
                
                completion(imageData)
            }
            task.resume()
    }

    
    func deleteLeagueItem(league: League) {
       

    }
    
    
}
