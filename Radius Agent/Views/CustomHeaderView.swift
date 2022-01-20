//
//  CustomHeaderView.swift
//  Radius Agent
//
//  Created by Karthi CK on 20/01/22.
//

import UIKit

class CustomHeaderView: UIView {
    
    // MARK: Properties

    lazy var facilityLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy private var separator: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = UIColor(named: "PeachGreenColor")
        
        addSubview(facilityLabel)
        addSubview(separator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        facilityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            facilityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            facilityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            facilityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
