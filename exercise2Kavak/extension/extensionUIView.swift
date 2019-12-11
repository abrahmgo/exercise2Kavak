//
//  extensionUIView.swift
//  exercise2Kavak
//
//  Created by Flink on 12/11/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - width / 2, y: bounds.midY - width / 2, width: width, height: width)).cgPath
        self.layer.mask = mask
    }
    
    func addShadowToCard(color: UIColor)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
}
