//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import UIKit
import Kingfisher
//import SDWebImage

class LeaguesTableViewController: UITableViewController,UICollectionViewDelegateFlowLayout,LeaguesView, UISearchResultsUpdating {
    
    
    
    var selectedSport : Sport = .football
    var leagues : [League]?
    var leaguesPresenter : LeaguesPresenter?
    var leaguesInteractor : LeaguesInteractor?
    var searchController = UISearchController(searchResultsController: nil)
    var filteredLeagues: [League]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
                searchController.obscuresBackgroundDuringPresentation = false
                searchController.searchBar.placeholder = "Search"
                navigationItem.searchController = searchController
                definesPresentationContext = true
        NetworkIntecator.startAnimating(view: view)
        let sport = getStringOfSelectedSport()
        tableView.customCellTitleHeader(cellTitle: sport)
        initDependencies()
        print(selectedSport)
    }
    
    func initDependencies(){
        leaguesInteractor = LeaguesInteractorImp()
        leaguesPresenter = LeaguesPresenterImp(interactor: leaguesInteractor!, leaguesView: self)
        leaguesPresenter?.getLeaguesFor(sport: selectedSport)
    }

    func showLeagues(leagues: [League]) {
        self.leagues = leagues
        self.filteredLeagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
            NetworkIntecator.stopAnimation()

            }
    }
    
    func showError(error: String) {
        AlertManager.showAlertWithoutTitle(message: "Error !!!", viewController: self)
        self.navigationController?.popViewController(animated: true)
        print("Erorrrrrrr:\(error)")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues?.count ?? 0
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell

       configureCell(cell, at: indexPath)

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSport == .tennis {
            AlertManager.showAlertWithoutTitle(message: "No League Details", viewController: self)
        }else{
            var fixtureVC = self.storyboard?.instantiateViewController(withIdentifier: "FixtureMatchesViewController") as? FixtureMatchesViewController
            let key = filteredLeagues?[indexPath.row].league_key
            fixtureVC?.leagueKey = key
            fixtureVC?.selectedSport = selectedSport
            fixtureVC?.league = filteredLeagues?[indexPath.row]
            navigationController?.pushViewController(fixtureVC!, animated: true)
        }
    }
    
    private func configureCell(_ cell: LeagueTableViewCell, at indexPath: IndexPath) {
        if let league = filteredLeagues?[indexPath.row] {
            cell.layer.borderColor = UIColor.yellow.cgColor
            cell.layer.borderWidth = 2
            cell.league_name?.text = league.league_name
            cell.league_img.layer.borderWidth = 2
            cell.league_img.layer.borderColor = UIColor.systemYellow.cgColor
            cell.league_img.clipsToBounds = true
            cell.league_img.layer.cornerRadius = 35
            cell.league_img.round() 
            configureCellImageView(cell.league_img, with: league.league_logo)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    private func configureCellImageView(_ imageView: UIImageView?, with imageURL: String?) {
        guard let imageView = imageView else { return }
        imageView.round()
        if let imageUrl = imageURL {
            let url = URL(string: imageUrl)
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "sports"))
        } else {
            imageView.image = UIImage(named: "sports")
        }
    }
    
    func getStringOfSelectedSport()->String{
        switch selectedSport{
        case .football:
            return "Football"
            break
        case .cricket:
            return "Cricket"
            break
        case .basketball:
            return "Basketball"
        default:
            return "Tennis"
            break
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            filteredLeagues = leagues?.filter { league in
                return league.league_name!.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            filteredLeagues = leagues
        }
        tableView.reloadData()
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




