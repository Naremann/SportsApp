//
//  FixtureMatchesViewController.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 25/04/2024.
//

import UIKit
import Kingfisher

class FixtureMatchesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FixturesViewProtocol , TeamsView{
    
    @IBOutlet weak var blankHeart: UIImageView!
    
    @IBOutlet weak var fillHeart: UIImageView!
    
    @IBOutlet weak var fixturesCollectionView: UICollectionView!
    
    var fixtures :[Fixture]?
    var upcomingFixture :[Fixture] = []
    var latestFixtures :[Fixture] = []
    var teams : [Team]?
    var fixturesInteractor : FixturesInteractorProtocol?
    var teamInteractor : TeamInteractor?
    var fixturesPresenterProtocol : FixturesPresenterProtocol?
    var selectedSport : Sport = .football
    var leagueKey :Int?
    var league : League?
    var database : Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixturesCollectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blankHeartTapped))
            blankHeart.isUserInteractionEnabled = true
            blankHeart.addGestureRecognizer(tapGestureRecognizer)

        database = CoreDataDatabase()
        teams = []
        fixturesInteractor = FixturesInteractor()
        teamInteractor = TeamInteractorImp()
        fixturesPresenterProtocol = FixturesPresenter(interactor: fixturesInteractor!, teamInteractor: teamInteractor!, fixturesView: self, teamsView: self)
       
        fixturesPresenterProtocol?.getFixturesFor(leagueKey: leagueKey!,sport: selectedSport)
        fixturesPresenterProtocol?.getTeamsFor(leagueKey: leagueKey!, sport: selectedSport)
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            if index == 0 {
                return self.drawTheTopSection()
            }else if index == 1{
                return self.drawTheMidSection()
            }else{
                return self.drawTeamsLastSection()
            }
        }
        fixturesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func showLeagues(fixtures: [Fixture]) {
        self.upcomingFixture.removeAll()
        self.latestFixtures.removeAll()
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
    func showTeams(teams: [Team]) {
        self.teams?.removeAll()
        DispatchQueue.main.async {
            for team in teams {
                self.teams?.append(team)
              }
            self.fixturesCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if upcomingFixture.count == 0 {
//            upcomingFixture.append(Fixture(league_key: 0, event_date: "", event_time: "", event_home_team: "", event_away_team: "", event_ft_result: "", home_team_logo: "", away_team_logo: ""))
//        }
//        if latestFixtures.count == 0 {
//            latestFixtures.append(Fixture(league_key: 0, event_date: "", event_time: "", event_home_team: "", event_away_team: "", event_ft_result: "", home_team_logo: "", away_team_logo: ""))
//        }
//        if teams?.count == 0 {
//            teams?.append(Team(team_key: 0, team_name: "", team_logo: "", players: nil, coaches: nil))
//        }
        
        switch section {
        case 0:
            print("First Count is \(upcomingFixture.count)")
            return upcomingFixture.count
        case 1:
            print("First Count is \(latestFixtures.count)")
            return latestFixtures.count
        default:
            return teams?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        switch indexPath.section {
        case 0:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixCell", for: indexPath) as! FixtureMatchesCell
            var imgFlag = true
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
            return cell
        case 1:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixCell", for: indexPath) as! FixtureMatchesCell
            cell.homeTeamText.text = latestFixtures[indexPath.row].event_home_team
            cell.awayTeamText.text = latestFixtures[indexPath.row].event_away_team
            cell.dateText.text = latestFixtures[indexPath.row].event_date
            cell.timeText.text = latestFixtures[indexPath.row].event_ft_result
            var urlHome = URL(string: latestFixtures[indexPath.row].home_team_logo ?? "")
            cell.homeTeamImage.kf.setImage(with: urlHome )
            var urlAway = URL(string: latestFixtures[indexPath.row].away_team_logo ?? "")
            cell.awayTeamImage.kf.setImage(with: urlAway )
            return cell
        case 2:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCustomCell
            configureTeamsLatestCell(cell, at: indexPath)
            return cell
        default:
            print("CELL")
            return UICollectionViewCell()
        }
        
       
    }
    
    private func configureTeamsLatestCell(_ cell: TeamsCustomCell, at indexPath: IndexPath) {
//        cell.backgroundColor = .white
       /* cell.homeTeamImage.isHidden = true
        cell.awayTeamImage.isHidden = true
        cell.awayTeamText.isHidden = true
        cell.homeTeamText.isHidden = true
        cell.timeText.isHidden = true
        cell.dateText.isHidden = true*/
       // cell.vs_img.isHighlighted = false

//        cell.team_image.isHidden = false
        let team = teams?[indexPath.item]
//        cell.team_image.layer.borderWidth = 2
//        cell.team_image.layer.borderColor = UIColor.systemYellow.cgColor
//        cell.team_image.layer.cornerRadius = 75
//        cell.round()
   

        guard let imageUrl = team?.team_logo else{
           return
        }
        let url = URL(string: imageUrl)
        cell.teamLogo.kf.setImage(with: url, placeholder: UIImage(named: "sports"))
        cell.teamNameLabel.text = team?.team_name
        print("TEMA LOGO:\(imageUrl)")
        
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    func drawTeamsLastSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(240))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 2, bottom: 24, trailing: 2)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }

    

    
    @objc func blankHeartTapped() {

        DispatchQueue.main.async {
            self.blankHeart.isHidden = true
            self.fillHeart.isHidden = false
        }
        var leagueUrl : String = ""
        guard let selectedLeague = league else {
            
            print("Selected league is nil")
            return
        }
        if let leagueLogo = selectedLeague.league_logo {
            leagueUrl = leagueLogo
        }
        print("LEAGUE URL: \(leagueUrl)")

       
        let leagueItem = League(league_key: leagueKey ?? 0, league_name: selectedLeague.league_name, league_logo: leagueUrl, logo_data: nil)
        database?.saveLeagueItem(league: leagueItem)
        print("leagueItem",leagueItem.league_key)
}
        

    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if teams?[indexPath.row].coaches?[0].coach_name == nil{
                AlertManager.showAlertWithoutTitle(message: "No Team Details", viewController: self)
            }else{
                var teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                teamVC.teamDetails = teams?[indexPath.row]
                self.navigationController?.pushViewController(teamVC, animated: true)
            }
        }else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        let headerName :String = {
            if indexPath.section == 0{
                if upcomingFixture.count == 0 {
                    return "No Upcoming Matches"
                }else{
                    return "Upcoming Matches"
                }
            }else if indexPath.section == 1{
                if latestFixtures.count == 0 {
                    return "No Latest Matches"
                }else{
                    return "Latest Matches"
                }
            }else{
                if teams?.count == 0 || teams?.count == nil {
                    return "No Teams"
                }else{
                    return "\(league?.league_name ?? "") Teams"
                }
            }
        }()
        
        header.configure(name: headerName)
        return header
    }
}
