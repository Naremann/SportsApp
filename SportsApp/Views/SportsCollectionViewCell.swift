//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Nareman on 23/04/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sport_img: UIImageView!
    
    
    @IBOutlet weak var sport_name_lb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     //   sport_img.setContentHuggingPriority(.required, for: .horizontal)
       // sport_img.setContentHuggingPriority(.required, for: .vertical)
        //sport_img.setContentCompressionResistancePriority(.required, for: .horizontal)
        //sport_img.setContentCompressionResistancePriority(.required, for: .vertical)
               
            
          /*     sport_name_lb.setContentHuggingPriority(.required, for: .horizontal)
        sport_name_lb.setContentHuggingPriority(.required, for: .vertical)
        sport_name_lb.setContentCompressionResistancePriority(.required, for: .horizontal)
        sport_name_lb.setContentCompressionResistancePriority(.required, for: .vertical)
     */
    }

}
