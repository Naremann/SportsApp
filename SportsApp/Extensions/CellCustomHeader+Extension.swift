//
//  UITableCellCustomHeader+Extension.swift
//  SportsApp
//
//  Created by Nareman on 28/04/2024.
//

import Foundation
import UIKit

extension UITableView{
    func customCellTitleHeader(cellTitle:String){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
               
               let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
               titleLabel.font = UIFont(name: "Pacifico-Regular", size: 30)
               titleLabel.textColor = .systemYellow
               titleLabel.text = cellTitle
               titleLabel.textAlignment = .center
               headerView.addSubview(titleLabel)
               
               self.tableHeaderView = headerView
           }
}

extension UICollectionView{
    func customCollectionCellTitleHeader(cellTitle:String){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 30)
        titleLabel.text = cellTitle
        titleLabel.textColor = .systemYellow
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
        self.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.addSubview(headerView)
           }
}
