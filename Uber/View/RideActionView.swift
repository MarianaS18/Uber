//
//  RideActionView.swift
//  Uber
//
//  Created by Mariana Steblii on 09/04/2022.
//

import UIKit

class RideActionView: UIView {
    // MARK: - Private properties
    private let titleLabel: UILabel =  {
        let label = UILabel().createLabel("Test title", UIFont.systemFont(ofSize: 18), .black)
        label.textAlignment = .center
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel().createLabel("Test address", UIFont.systemFont(ofSize: 16), .lightGray)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        let label = UILabel().createLabel("X", UIFont.systemFont(ofSize: 30), .white)
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
        return view
    }()
    
    private let uberXLabel: UILabel = {
        let label = UILabel().createLabel("UberX", UIFont.systemFont(ofSize: 18), .black)
        label.textAlignment = .center
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton().createBlackButton(withText: "CONFIRM UBERX")
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupUI() {
        backgroundColor = .white
        addShadow()
    }
    
    private func setupConstraints() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop: 12)
        
        addSubview(infoView)
        infoView.centerX(inView: self)
        infoView.anchor(top: stack.bottomAnchor, paddingTop: 16, width: 60, height: 60)
        infoView.layer.cornerRadius = 30
        
        addSubview(uberXLabel)
        uberXLabel.anchor(top: infoView.bottomAnchor, paddingTop: 8)
        uberXLabel.centerX(inView: self)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        addSubview(separatorView)
        separatorView.anchor(top: uberXLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, height: 0.75)
        
        addSubview(actionButton)
        actionButton.anchor(top: separatorView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16)
    }
    
    // MARK: - Private @objc functions
    @objc private func actionButtonPressed() {
        print("DEBUG: 123")
    }
}
