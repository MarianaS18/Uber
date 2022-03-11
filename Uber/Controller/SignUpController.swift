//
//  SignUpController.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        return UILabel().createLabel("UBER", UIFont(name: "Avenir-Light", size: 36)!, UIColor(white: 1, alpha: 0.8))
    }()
    
    private lazy var emailContainerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textField: emailTextField)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createTextField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private lazy var nameContainerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_person_outline_white_2x")!, textField: nameTextField)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private let nameTextField: UITextField = {
        return UITextField().createTextField(withPlaceholder: "Full Name", isSecureTextEntry: false)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createTextField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private lazy var accountTypeConteinerView: UIView = {
        let containerView = UIView().createContainerView(image: UIImage(named: "ic_account_box_white_2x")!, segmentedControl: segmentedControl)
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return containerView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Rider", "Driver"])
        segmentedControl.backgroundColor = .backgroundColor
        segmentedControl.tintColor = UIColor(white: 1, alpha: 0.87)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton().createBlueButton(withText: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton().createTextButton(text: "Already have an account? ", nextText: "Log In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel().createErrorLabel()
        label.isHidden = true
        return label
    }()
    
    // MARK: - Public properties
    var firebaseService = FirebaseService()
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private funtions
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        firebaseService.delegate = self
        
        // hide navigation bar
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, passwordContainerView, accountTypeConteinerView, signInButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(errorLabel)
        errorLabel.centerX(inView: view)
        errorLabel.anchor(top: stackView.bottomAnchor, paddingTop: 12)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    // MARK: - objc functions
    @objc private func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = nameTextField.text else { return }
        let accountTypeIndex = segmentedControl.selectedSegmentIndex

        firebaseService.signIn(email: email, username: fullName, password: password, accountTypeIndex: accountTypeIndex)
    }
    
}

// MARK: - FirebaseServiceDelegate
extension SignUpController: FirebaseServiceDelegate {
    func didPassed() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didFailedWithError(error: String) {
        errorLabel.isHidden = false
        errorLabel.text = error
    }
}
