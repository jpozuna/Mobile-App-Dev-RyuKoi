//
//  CommunitiesTableViewCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
// MARK: TODO
// need to add more little details to each event cell square

import UIKit

class CommunitiesEventCell: UICollectionViewCell {
    
    static let identifier = "CommunityEventCell"
    
    private let eventView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        v.layer.cornerRadius = 12
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 4
        v.layer.shadowOffset = .zero
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let eventLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            eventView.backgroundColor = isSelected
                ? UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 0.53)
                : UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(eventView)
        eventView.addSubview(eventLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            eventLabel.centerXAnchor.constraint(equalTo: eventView.centerXAnchor),
            eventLabel.centerYAnchor.constraint(equalTo: eventView.centerYAnchor),
            eventLabel.leadingAnchor.constraint(greaterThanOrEqualTo: eventView.leadingAnchor, constant: 8),
            eventLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
