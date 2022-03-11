//
//  UILabel extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

extension UILabel {

    func createLabel(_ text: String, _ font: UIFont, _ color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .red
        label.textAlignment = .center
        return label
    }
}
