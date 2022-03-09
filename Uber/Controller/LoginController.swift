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
        return UILabel().createLabel(withText: "UBER", font: UIFont(name: "Avenir-Light", size: 36)!)
    }()
    
    private lazy var emailContainerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textField: emailTextField)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createTextField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createTextField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: UIButton = {
        return UIButton().createBlueButton(withText: "Log In")
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton().createTextButton(text: "Don´t have an account? ", nextText: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
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
        view.backgroundColor = .backgroundColor
        
        // hide navigation bar
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    // MARK: - objc functions
    @objc private func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
