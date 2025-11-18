//
//  CategoriesTableViewCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var categoryLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        categoryLabel = setupLabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.67)
        wrapperCellView.layer.borderWidth = 1 // may be subject to change
        wrapperCellView.layer.cornerRadius = 10 // may also be subject to changes
        //adding shadow to the cells
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.4
        
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabel()->UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(label)
        return label
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),// add padding at the bottom?
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            categoryLabel.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: wrapperCellView.centerXAnchor),
            categoryLabel.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),//maybe subject to change
            categoryLabel.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20), // width or height anchor....?? check back in later
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 104) // change to 104?
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
