//
//  PreferenceTokenCellCollectionViewCell.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class PreferenceTokenCellCollectionViewCell: UICollectionViewCell {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupLabel()
        initConstraints()
    }
    
    func setupContentView() {
        contentView.backgroundColor = UIColor(red: 0xB8/255, green: 0x39/255, blue: 0x0E/255, alpha: 1.0)
        contentView.layer.cornerRadius = 18   // pill shape
        contentView.layer.masksToBounds = true
    }
    
    func setupLabel() {
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
