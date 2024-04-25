//
//  UIView+Extensions.swift
//  SportsApp
//
//  Created by Nareman on 25/04/2024.
//

import Foundation
import UIKit

extension UIView{
    func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).cgPath
        self.layer.mask = mask
    }
}
