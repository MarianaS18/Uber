//
//  LocationCell.swift
//  Uber
//
//  Created by Mariana Steblii on 11/03/2022.
//

import UIKit

class LocationCell: UITableViewCell {
    
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        return UILabel().createLabel("Test titl", UIFont.systemFont(ofSize: 14), UIColor.black)
    }()
    
    private let addressLabel: UILabel = {
        return UILabel().createLabel("Test address", UIFont.systemFont(ofSize: 14), UIColor.gray)
    }()

    // MARK: - View functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        addSubview(stackView)
        stackView.centerY(inView: self)
        stackView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions

}
