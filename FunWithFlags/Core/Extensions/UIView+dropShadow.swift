//
//  UIView+dropShadow.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import UIKit

extension UIView {
    func dropShadowForCell() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func dropShadowBottom() {
        let contactRect = CGRect(x: 2,
                                 y: self.frame.height,
                                 width: self.frame.width - 4,
                                 height: 6)
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 7
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
