//
//  UIButton extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

extension UIButton {
    
    func createBlueButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.setTitle(text, for: .normal)
        button.backgroundColor = .mainBlue
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
    func createTextButton(text: String, nextText: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(
            string: nextText,
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.mainBlue]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
    func createBackButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    func createBlackButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(text, for: .normal)
        button.backgroundColor = .black
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
}
