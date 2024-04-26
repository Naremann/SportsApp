//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import UIKit
import Kingfisher
//import SDWebImage

class LeaguesTableViewController: UITableViewController,LeaguesView {
    
    var selectedSport : Sport = .football
    var leagues : [League]?
    var leaguesPresenter : LeaguesPresenter?
    var leaguesInteractor : LeaguesInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        leaguesInteractor = LeaguesInteractorImp()
        leaguesPresenter = LeaguesPresenterImp(interactor: leaguesInteractor!, leaguesView: self)
        leaguesPresenter?.getLeaguesFor(sport: selectedSport)
        
        print(selectedSport)
    }

    func showLeagues(leagues: [League]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
    }
    
    func showError(error: String) {
        print("Erorrrrrrr:\(error)")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        /*let cellContentView = UIView()
           cell.contentView.addSubview(cellContentView)
           cellContentView.translatesAutoresizingMaskIntoConstraints = false
           
           
           let leadingConstraint = cellContentView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20)
           let topConstraint = cellContentView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20)
           let trailingConstraint = cell.contentView.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: 20)
        let bottomConstraint = cell.contentView.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: 20)
           NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])*/
           
        configureCell(cell, at: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var fixtureVC = self.storyboard?.instantiateViewController(withIdentifier: "FixtureMatchesViewController") as? FixtureMatchesViewController
        var key = leagues?[indexPath.row].league_key
        fixtureVC?.leagueKey = key
        fixtureVC?.selectedSport = selectedSport
        print(fixtureVC?.leagueKey)
        navigationController?.pushViewController(fixtureVC!, animated: true)
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let league = leagues?[indexPath.row] {
            cell.textLabel?.text = league.league_name

            configureCellImageView(cell.imageView, with: league.league_logo)
        }
    }

    private func configureCellImageView(_ imageView: UIImageView?, with imageURL: String?) {
        guard let imageView = imageView else { return }
        imageView.frame.size = CGSize(width: 40, height: 40)
        imageView.round()
        if let imageUrl = imageURL {
            let url = URL(string: imageUrl)
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "sports"))
        } else {
            imageView.image = UIImage(named: "sports")
        }
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


