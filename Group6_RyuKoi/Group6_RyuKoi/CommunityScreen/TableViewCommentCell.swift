//
//  TableViewCommentCell.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit

class TableViewCommentCell: UITableViewCell {
    var wrapperCellView: UIView!
    var name: UILabel!
    var comment: UILabel!
    var date: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupWrapperCellView()
        setupName()
        setupComment()
        setupDate()
        initConstraints()
        
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UIView()
        wrapperCellView.layer.cornerRadius = 12
        wrapperCellView.clipsToBounds = true
        wrapperCellView.backgroundColor = UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 0.53)
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupName(){
        name = UILabel()
        name.font = .boldSystemFont(ofSize: 16)
        name.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(name)
    }
    
    func setupComment(){
        comment = UILabel()
        comment.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(comment)
    }
    
    func setupDate(){
        date = UILabel()
        date.font = .italicSystemFont(ofSize: 12)
        date.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(date)
    }
    
    func initConstraints(){
            NSLayoutConstraint.activate([
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                name.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
                name.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 5),
                
                comment.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
                comment.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
                
                date.topAnchor.constraint(equalTo: comment.bottomAnchor, constant: 10),
                date.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -5),
                
                wrapperCellView.heightAnchor.constraint(equalToConstant: 70)
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
