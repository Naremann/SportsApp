//
//  PlayerCustomCell.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 27/04/2024.
//

import UIKit

class PlayerCustomCell: UITableViewCell {

    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    
    @IBOutlet weak var playerRating: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
