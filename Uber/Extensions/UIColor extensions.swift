//
//  UIColor extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

extension UIColor {
    static func createRGBcolor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.createRGBcolor(red: 25, green: 25, blue: 25)
    static let mainBlue = UIColor.createRGBcolor(red: 17, green: 154, blue: 237)
}
