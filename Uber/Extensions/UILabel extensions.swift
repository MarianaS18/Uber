//
//  UILabel extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

extension UILabel {
    
    func createLabel(withText text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = UIColor(white: 1, alpha: 0.8)
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
