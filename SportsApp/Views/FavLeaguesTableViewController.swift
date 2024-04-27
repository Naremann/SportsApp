//
//  FavLeaguesTableViewController.swift
//  SportsApp
//
//  Created by Nareman on 27/04/2024.
//

import UIKit

class FavLeaguesTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegateFlowLayout ,FavoriteLeaguesView{
   
 
    
    var presenter: FavoriteLeaguesPresenter!
    var favoriteLeagues: [League] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        presenter = FavoriteLeaguesPresenterImpl(view: self , database: CoreDataDatabase())
        super.viewDidLoad()
        presenter.viewDidLoad()

       

    }
    
    func displayFavoriteLeagues(leagues: [League]) {
        favoriteLeagues = leagues
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageAndLabelTableViewCell
       
        let league = favoriteLeagues[indexPath.row]
        cell.league_name.text = league.league_name
        cell.league_img.layer.borderWidth = 7
        cell.league_img.layer.borderColor = UIColor.red.cgColor
        cell.league_img.layer.cornerRadius = 40
        cell.league_img.round()
        if let data = league.logo_data {
            cell.league_img.image = UIImage(data: data)

               } else {
                   cell.league_img.image = UIImage(named: "sports")
               }
               
          
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
