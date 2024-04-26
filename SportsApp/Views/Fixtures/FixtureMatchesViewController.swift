//
//  FixtureMatchesViewController.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import UIKit
import Kingfisher

class FixtureMatchesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FixturesViewProtocol {
    
    @IBOutlet weak var fixturesCollectionView: UICollectionView!
    
    var fixtures :[Fixture]?
    var upcomingFixture :[Fixture] = []
    var latestFixtures :[Fixture] = []
    var fixturesInteractor : FixturesInteractorProtocol?
    var fixturesPresenterProtocol : FixturesPresenterProtocol?
    var selectedSport : Sport = .football
    var leagueKey :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixturesInteractor = FixturesInteractor()
        fixturesPresenterProtocol = FixturesPresenter(interactor: fixturesInteractor!, fixturesView: self)
        fixturesPresenterProtocol?.getFixturesFor(leagueKey: leagueKey!,sport: selectedSport)
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            if index == 0 {
                return self.drawTheTopSection()
            }else{
                return self.drawTheMidSection()
            }
        }
        fixturesCollectionView.setCollectionViewLayout(layout, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func showLeagues(fixtures: [Fixture]) {
        
        DispatchQueue.main.async {
            for fixture in fixtures {
                if fixture.event_ft_result == "" {
                    self.upcomingFixture.append(fixture)
                }else{
                    self.latestFixtures.append(fixture)
                }
              }
            self.fixturesCollectionView.reloadData()
        }
    }
    
    func showError(error: String) {
        print("Error:\(error)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("First Count is \(upcomingFixture.count)")
            return upcomingFixture.count
        default:
            print("First Count is \(latestFixtures.count)")
            return latestFixtures.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixCell", for: indexPath) as! FixtureMatchesCell
        
        switch indexPath.section {
        case 0:
            print(upcomingFixture[indexPath.row])
            cell.homeTeamText.text = upcomingFixture[indexPath.row].event_home_team
            cell.awayTeamText.text = upcomingFixture[indexPath.row].event_away_team
            cell.dateText.text = upcomingFixture[indexPath.row].event_date
            cell.timeText.text = upcomingFixture[indexPath.row].event_time
            var urlHome = URL(string: upcomingFixture[indexPath.row].home_team_logo ?? "")
            cell.homeTeamImage.kf.setImage(with: urlHome )
            print("The Home is \(upcomingFixture[indexPath.row].home_team_logo ?? "")")
            var urlAway = URL(string: upcomingFixture[indexPath.row].away_team_logo ?? "")
            cell.awayTeamImage.kf.setImage(with: urlAway )
            print("The Away is \(upcomingFixture[indexPath.row].away_team_logo ?? "")")
        default:
            cell.homeTeamText.text = latestFixtures[indexPath.row].event_home_team
            cell.awayTeamText.text = latestFixtures[indexPath.row].event_away_team
            cell.dateText.text = latestFixtures[indexPath.row].event_date
            cell.timeText.text = latestFixtures[indexPath.row].event_ft_result
            var urlHome = URL(string: latestFixtures[indexPath.row].home_team_logo ?? "")
            cell.homeTeamImage.kf.setImage(with: urlHome )
            var urlAway = URL(string: latestFixtures[indexPath.row].away_team_logo ?? "")
            cell.awayTeamImage.kf.setImage(with: urlAway )
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 200)
    }
    
    
    
    
    func drawTheTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(190))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 2, bottom: 8, trailing: 2)
        
        return section
    }

    func drawTheMidSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(190))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 2, bottom: 8, trailing: 2)
        
        return section
    }
}
