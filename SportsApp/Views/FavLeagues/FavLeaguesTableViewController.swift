//
//  FavLeaguesTableViewController.swift
//  SportsApp
//
//  Created by Nareman on 27/04/2024.
//

import UIKit
import Reachability

class FavLeaguesTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegateFlowLayout ,FavoriteLeaguesView{
   
    var reachability = try! Reachability()
    
    
    var presenter: FavoriteLeaguesPresenter!
    var favoriteLeagues: [League] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.customCellTitleHeader(cellTitle: "Favorite Leagues ⚽❤️⚽")
        presenter = FavoriteLeaguesPresenterImpl(view: self , database: CoreDataDatabase())
        super.viewDidLoad()
        presenter.viewDidLoad()

       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HELOOOO, viewWillAppear")
        presenter.viewDidLoad()
        tableView.reloadData()
    }
    
    func displayFavoriteLeagues(leagues: [League]) {
        favoriteLeagues = leagues
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteLeagues.isEmpty {
                return 1
            } else {
                return favoriteLeagues.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if favoriteLeagues.isEmpty{
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
             showNoFaviritesImgInTheCenter(cell: cell)
                   return cell
                    
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageAndLabelTableViewCell
            
            configureFaviriteCell(cell: cell,index: indexPath.row)
            
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if favoriteLeagues.isEmpty {
            return tableView.frame.height
        }else{
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if favoriteLeagues.isEmpty{
            print("No Leagues")
        }else{
            if reachability.connection != .unavailable {
                print("AAAAAAAA")
                print(favoriteLeagues.count)
                var fixtureVC = self.storyboard?.instantiateViewController(withIdentifier: "FixtureMatchesViewController") as? FixtureMatchesViewController
                let key = favoriteLeagues[indexPath.row].league_key
                print("the league key is ",key)
                fixtureVC?.leagueKey = key
                fixtureVC?.selectedSport = .football
                fixtureVC?.league = favoriteLeagues[indexPath.row]
                navigationController?.pushViewController(fixtureVC!, animated: true)
            }else{
                AlertManager.showAlertWithTitle(title: "No Internet", message: "Please Check Your Internet Connection !!!", on: self)
            }
        }
    }
    
    
    func configureFaviriteCell(cell:ImageAndLabelTableViewCell,index:Int){
     
       
        let league = favoriteLeagues[index]
        cell.layer.borderColor = UIColor.yellow.cgColor
        cell.layer.borderWidth = 2
        
        cell.league_name.text = league.league_name
        cell.league_img.layer.borderWidth = 2
        cell.league_img.layer.borderColor = UIColor.systemYellow.cgColor
        cell.league_img.layer.cornerRadius = 40
        cell.league_img.clipsToBounds = true


        cell.league_img.round()
        if let data = league.logo_data {
            cell.league_img.image = UIImage(data: data)

               } else {
                   cell.league_img.image = UIImage(named: "sports")
               }
    }
    
    func showNoFaviritesImgInTheCenter(cell:UITableViewCell){
        let emptyImageView = UIImageView()
        emptyImageView.contentMode = .scaleAspectFit
     emptyImageView.tintColor = .systemYellow
     emptyImageView.image = UIImage(systemName: "heart.slash")
        
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(emptyImageView)
        
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            emptyImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }


    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            AlertManager.showAlertForDeleteConfirmation(message: "Are you sure you want to delete this item?", viewController: self) {
                self.presenter.deleteLeague(league: self.favoriteLeagues[indexPath.row])
                self.presenter.viewDidLoad()
                self.tableView.reloadData()
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
