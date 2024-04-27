//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 27/04/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var playersTableView: UITableView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    
    @IBOutlet weak var coachName: UILabel!
    
    var teamDetails : Team?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDetails?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCustomCell
        var player = teamDetails?.players?[indexPath.row]
        cell.playerName.text = player?.player_name
        cell.playerPosition.text = "Position: \(player?.player_type ?? "")"
        cell.playerNumber.text = "No.\(player?.player_number ?? "")"
        cell.playerRating.text = "Rating: \(player?.player_rating ?? "   ")★"
        cell.playerImage.kf.setImage(with: URL(string: player?.player_image ?? ""),placeholder: UIImage(named: "sports"))
        
//        cell.playerImage.kf.setImage(with: player?.player_image )
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        teamName.text = "\(teamDetails?.team_name ?? "")"
        coachName.text = "Coach: \(teamDetails?.coaches?[0].coach_name ?? "")"
        teamLogo.kf.setImage(with: URL(string: teamDetails?.team_logo ?? "") ,placeholder: UIImage(named: "sports"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playersTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
