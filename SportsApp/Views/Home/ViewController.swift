//
//  ViewController.swift
//  SportsApp
//
//  Created by Nareman on 22/04/2024.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , SportsView{
   
    

    
    var sports: [SportItem] = []
    
    
    func showSports(sportItems: [SportItem]) {
        self.sports = sportItems
        collectionView.reloadData()
    }
    
    
    var sportsPresenter : SportsPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsPresenter = SportsPresenterImp(sportsView: self)
        sportsPresenter.viewDidload()
        registerCustomCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        let sportItem = sportsPresenter.sportItemAt(Index: indexPath.row)
        cell.sport_name_lb.text = sportItem.sportTitle
        cell.sport_img.image = UIImage(named: (sportItem.sportImage))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height:180)
    }
    
    
   
    func registerCustomCell(){
        let cellNib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.frame = view.bounds
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        sportsPresenter.didSelectedSportAt(index: indexPath.row)
    }
    
    
    
    func navigateToLeaguesTableViewController(sport:Sport){
        let leaguesTableViewController = storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as! LeaguesTableViewController
        leaguesTableViewController.selectedSport = checkSelectedSport(sport: sport)
        navigationController?.pushViewController(leaguesTableViewController, animated: true)
    }

    func checkSelectedSport(sport:Sport)->Sport{
        switch sport {
        case .football:
            return .football
        case .basketball:
            return .basketball

        case .cricket:
            return .cricket

        default:
            return.tennis
        }
    }
    
   
    
}

