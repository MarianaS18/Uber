//
//  LoginController.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Private properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()

    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // change the color of the text on status bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
    }
}
