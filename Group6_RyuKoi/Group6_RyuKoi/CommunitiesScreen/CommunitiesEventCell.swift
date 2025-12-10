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
    
    /*
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
    }()*/
    
    private let eventView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let notifIcon: UIButton = {
        let iv = UIButton()
        iv.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let eventLabel: UILabel = {
        /*
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label*/
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            // Highlight when selected
            eventView.backgroundColor = isSelected
                ? UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.55)
                : UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    //MARK: Setup
    
    private func setupViewHierarchy() {
        contentView.addSubview(eventView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(notifIcon)
        eventView.addSubview(eventLabel)
        eventView.addSubview(bioLabel)
    }
    /*
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
    }*/
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            // Lesson container
            eventView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // date label
            dateLabel.topAnchor.constraint(equalTo: eventView.topAnchor, constant: 14),
            dateLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 12),

            // Notif icon
            notifIcon.topAnchor.constraint(equalTo: eventView.topAnchor, constant: 12),
            notifIcon.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: -12),
            notifIcon.widthAnchor.constraint(equalToConstant: 28),
            notifIcon.heightAnchor.constraint(equalToConstant: 28),

            // Event Label
            eventLabel.topAnchor.constraint(equalTo: notifIcon.bottomAnchor, constant: 12),
            eventLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 12),
            eventLabel.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: -12),
            
            // Bio label needs to be shortened if too long
            bioLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: eventLabel.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: -12),
            bioLabel.bottomAnchor.constraint(equalTo: eventView.bottomAnchor, constant: -14)
        ])
    }
    
    // MARK: - Config
    func configure(with event: Event) {
        eventLabel.text = event.name
        bioLabel.text = event.bio
        dateLabel.text = event.date//.formatted(.dateTime)
        
        //Maybe fill for toggled like in favorites
        notifIcon.setImage(UIImage(systemName: "bell"), for: .normal)
        notifIcon.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
