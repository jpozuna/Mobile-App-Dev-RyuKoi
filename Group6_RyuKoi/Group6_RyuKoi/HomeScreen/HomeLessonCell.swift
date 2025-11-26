//
//  HomeTableViewCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class HomeLessonCell: UICollectionViewCell {
    
    static let identifier = "HomeLessonCell"
    
    let lessonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lessonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            // Highlight when selected
            lessonView.backgroundColor = isSelected
                ? UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 0.53)
                : UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lessonView)
        lessonView.addSubview(lessonLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lessonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lessonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lessonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lessonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            lessonLabel.centerXAnchor.constraint(equalTo: lessonView.centerXAnchor),
            lessonLabel.centerYAnchor.constraint(equalTo: lessonView.centerYAnchor),
            lessonLabel.leadingAnchor.constraint(greaterThanOrEqualTo: lessonView.leadingAnchor, constant: 8),
            lessonLabel.trailingAnchor.constraint(lessThanOrEqualTo: lessonView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
