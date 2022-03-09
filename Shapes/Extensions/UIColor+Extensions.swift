//
//  UIColor+Extensions.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1.0)
    }
}
