//
//  LocationInputView.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    // MARK: - Private properties
    private let backButton: UIButton = {
        let button = UIButton().createBackButton()
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        return UILabel().createLabel("", UIFont.systemFont(ofSize: 16), UIColor.darkGray)
    }()
    
    private let startLocationIndicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
         view.backgroundColor = .darkGray
         return view
    }()
    
    private let destinationIndicatorView: UIView = {
        let view = UIView()
         view.backgroundColor = .black
         return view
    }()
    
    private let startLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Current Location"
        textField.backgroundColor = .systemGroupedBackground
        textField.isEnabled = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.setLeftPadding(8)
        return textField
    }()
    
    private let destinationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a Destination"
        textField.backgroundColor = .lightGray
        textField.returnKeyType = .search
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.setLeftPadding(8)
        return textField
    }()
    
    
    // MARK: - Public properties
    weak var delegate: LocationInputViewDelegate?
    
    // MARK: - View functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupUI() {
        addShadow()
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        addSubview(backButton)
        backButton.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 44, paddingLeft: 16, width: 24, height: 25)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: backButton)
        
        addSubview(startLocationTextField)
        startLocationTextField.centerX(inView: self)
        startLocationTextField.anchor(top: backButton.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 40, paddingRight: 40, height: 35)
        
        addSubview(destinationTextField)
        destinationTextField.centerX(inView: self)
        destinationTextField.anchor(top: startLocationTextField.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 40, paddingRight: 40, height: 35)
        
        addSubview(startLocationIndicatorView)
        startLocationIndicatorView.centerY(inView: startLocationTextField)
        startLocationIndicatorView.anchor(left: self.leftAnchor, paddingLeft: 20, width: 6, height: 6)
        startLocationIndicatorView.layer.cornerRadius = 3
        
        addSubview(destinationIndicatorView)
        destinationIndicatorView.centerY(inView: destinationTextField)
        destinationIndicatorView.anchor(left: self.leftAnchor, paddingLeft: 20, width: 6, height: 6)
        destinationIndicatorView.layer.cornerRadius = 3
        
        addSubview(linkingView)
        linkingView.centerX(inView: startLocationIndicatorView)
        linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor, paddingTop: 4, paddingBottom: 4, width: 1)
        linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, paddingTop: 8, width: 2, height: 30)
        
    }
    
    private func fetchData() {
        FirebaseService.shared.fetchUserData { username in
            self.titleLabel.text = username
        }
    }
    
    // MARK: - objc functions
    @objc private func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
