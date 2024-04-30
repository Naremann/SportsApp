//
//  ViewController.swift
//  SportsApp
//
//  Created by Nareman on 22/04/2024.
//

import UIKit
import Reachability
class ViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , SportsView{
   
    
    var reachabilty = try! Reachability()
    
    var sports: [SportItem] = []
    
    
    func showSports(sportItems: [SportItem]) {
        self.sports = sportItems
        collectionView.reloadData()
    }
    
    
    var sportsPresenter : SportsPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 100, left: 45, bottom: 50, right: 45)
      
        collectionView.customCollectionCellTitleHeader(cellTitle: "Welcome To Sports App ⚽️")
        collectionView.collectionViewLayout = layout
        sportsPresenter = SportsPresenterImp(sportsView: self)
        sportsPresenter.viewDidload()
        registerCustomCell()
        
    }
    
    
    /*func customCollectionCellTitleHeader(cellTitle: String) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 30)
        titleLabel.text = cellTitle
        titleLabel.textColor = .systemYellow
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.addSubview(headerView)
    }*/

    


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        let sportItem = sportsPresenter.sportItemAt(Index: indexPath.row)
        cell.sport_img.contentMode = .scaleAspectFit
        cell.sport_name_lb.text = sportItem.sportTitle
        cell.sport_img.image = UIImage(named: (sportItem.sportImage))
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.yellow.cgColor
        cell.clipsToBounds = true
        
        cell.layer.cornerRadius = 10
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
        if reachabilty.connection != .unavailable {
                sportsPresenter.didSelectedSportAt(index: indexPath.row)
            } else {
                AlertManager.showAlertWithTitle(title: "No Internet", message: "Please Check Your Internet Connection !!!", on: self)
            }
        
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

