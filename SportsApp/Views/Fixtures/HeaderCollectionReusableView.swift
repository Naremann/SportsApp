//
//  HeaderCollectionReusableView.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 29/04/2024.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollection"
    
    private let label :UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .left
        label.font = UIFont(name: "Pacifico-Regular", size: 30)
        label.textColor = .systemYellow
        
        return label
    }()
    
    public func configure(name:String){
        label.text = name
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
