//
//  TableViewNotificationCell.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TableViewNotificationCell: UITableViewCell {
    var wrapperCellView: UIView!
    var eventName: UILabel!
    var messageText: UILabel!
    var date: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupWrapperCellView()
        setupEventName()
        setupMessageText()
        setupDate()
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupEventName(){
        eventName = UILabel()
        eventName.text = "Event Name"
        eventName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(eventName)
    }
    func setupMessageText(){
        messageText = UILabel()
        messageText.text = "User 1 has commented on Event Name"
        messageText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageText)
    }
    
    func setupDate(){
        date = UILabel()
        date.text = "11/16/2025"
        date.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(date)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            eventName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            eventName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 5),
            
            messageText.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 10),
            messageText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 5),
            
            date.topAnchor.constraint(equalTo: messageText.bottomAnchor, constant: 10),
            date.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -5),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 100)
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
