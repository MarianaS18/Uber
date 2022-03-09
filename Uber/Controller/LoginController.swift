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
    
    private lazy var emailContainerView: UIView = {
        let containerView = UIView()
    
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        containerView.addSubview(imageView)
        imageView.centerY(inView: containerView)
        imageView.anchor(left: containerView.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        containerView.addSubview(emailTextField)
        emailTextField.centerY(inView: imageView)
        emailTextField.anchor(left: imageView.rightAnchor, paddingLeft: 12)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        containerView.addSubview(separatorView)
        separatorView.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return containerView
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textField
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
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 36, paddingLeft: 16, paddingRight: 16, height: 50)
    }
}
