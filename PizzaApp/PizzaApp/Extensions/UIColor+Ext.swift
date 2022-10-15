//
//  UIColor+Ext.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

extension UIColor {
    static let darkWhite = UIColor(hex: 0xF3F5F9)
    static let transparentPink = UIColor(hex: 0xFD3A69, alpha: 0.2)
    static let darkPink = UIColor(hex: 0xFD3A69)
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF

        self.init(
            red: .init(red) / 255,
            green: .init(green) / 255,
            blue: .init(blue) / 255,
            alpha: alpha
        )
    }
}
