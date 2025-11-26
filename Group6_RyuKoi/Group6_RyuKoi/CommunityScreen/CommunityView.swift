//
//  CommunityView.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit

class CommunityView: UIView {
    var backBtn: UIButton!
    var navBar: TopNavigationBarView!
    var eventNameContainer: UIView!
    var eventName: UILabel!
    var bioContainer: UIView!
    var date: UILabel!
    var bio: UILabel!
    var notificationBtn: UIButton!
    var commentsTableView: UITableView!
    var sendBtn: UIButton!
    var message: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupBackBtn()
        setupNavBar()
        setupEventNameContainer()
        setupEventName()
        setupBioContainer()
        setupDate()
        setupBio()
        setupNotificationButton()
        setupCommentsTableView()
        setupSendBtn()
        setupMessage()
        initConstraints()
    }
    
    func setupBackBtn() {
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .label
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backBtn)
    }
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupEventNameContainer(){
        eventNameContainer = UIView()
        eventNameContainer.backgroundColor = UIColor(red: 184/255, green: 57/255, blue: 14/255, alpha: 0.33)
        eventNameContainer.layer.cornerRadius = 20
        eventNameContainer.clipsToBounds = true
        eventNameContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(eventNameContainer)
    }
    
    func setupEventName(){
        eventName = UILabel()
        eventName.textColor = .black
        eventName.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        eventName.text = "Event Name"
        eventName.translatesAutoresizingMaskIntoConstraints = false
        eventNameContainer.addSubview(eventName)
    }
    
    func setupBioContainer(){
        bioContainer = UIView()
        bioContainer.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        bioContainer.clipsToBounds = true
        bioContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bioContainer)
    }
    
    func setupDate(){
        date = UILabel()
        date.textColor = .black
        date.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        date.text = "Date of the event"
        date.translatesAutoresizingMaskIntoConstraints = false
        bioContainer.addSubview(date)
    }
    
    func setupBio(){
        bio = UILabel()
        bio.textColor = .black
        bio.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        bio.text = "The event Bio is to be placed here so that users know what the event is about"
        bio.numberOfLines = 0
        bio.lineBreakMode = .byWordWrapping
        bio.translatesAutoresizingMaskIntoConstraints = false
        bioContainer.addSubview(bio)
    }
    
    func setupNotificationButton(){
        notificationBtn = UIButton()
        notificationBtn.setImage(UIImage(systemName: "bell"), for: .normal)
        notificationBtn.tintColor = .black
        notificationBtn.imageView?.contentMode = .scaleAspectFit
        notificationBtn.translatesAutoresizingMaskIntoConstraints = false
        bioContainer.addSubview(notificationBtn)
    }
    
    func setupCommentsTableView(){
        commentsTableView = UITableView()
        commentsTableView.register(TableViewCommentCell.self, forCellReuseIdentifier: "comment")
        commentsTableView.backgroundColor = .clear
        commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentsTableView)
    }
    
    func setupSendBtn(){
        sendBtn = UIButton()
        sendBtn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendBtn.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        sendBtn.imageView?.contentMode = .scaleAspectFit
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sendBtn)
    }
    
    func setupMessage() {
        message = UITextView()
        message.backgroundColor = UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 0.57)
        message.font = UIFont.systemFont(ofSize: 16)
        message.textColor = .black
        message.isScrollEnabled = false
        message.layer.cornerRadius = 8
        message.translatesAutoresizingMaskIntoConstraints = false
        addSubview(message)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            backBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            //navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor ,constant: 20),
            navBar.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            eventNameContainer.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            eventNameContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            eventNameContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            eventName.topAnchor.constraint(equalTo: eventNameContainer.topAnchor, constant: 8),
            eventName.bottomAnchor.constraint(equalTo: eventNameContainer.bottomAnchor, constant: -8),
            eventName.centerXAnchor.constraint(equalTo: eventNameContainer.centerXAnchor),
            
            bioContainer.topAnchor.constraint(equalTo: eventNameContainer.bottomAnchor, constant: 16),
            bioContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bioContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bioContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            date.leadingAnchor.constraint(equalTo: bioContainer.leadingAnchor, constant: 16),
            
            bio.leadingAnchor.constraint(equalTo: bioContainer.leadingAnchor, constant: 16),
            bio.trailingAnchor.constraint(equalTo: bioContainer.trailingAnchor, constant: -16),
            bio.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10),
            
            notificationBtn.trailingAnchor.constraint(equalTo: bioContainer.trailingAnchor, constant: -10),
            notificationBtn.widthAnchor.constraint(equalToConstant: 50),
            notificationBtn.heightAnchor.constraint(equalToConstant: 50),
            
            date.topAnchor.constraint(equalTo: bioContainer.topAnchor, constant: 16),
            notificationBtn.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 10),
            notificationBtn.bottomAnchor.constraint(equalTo: bioContainer.bottomAnchor, constant: -16),
            
            commentsTableView.topAnchor.constraint(equalTo: bioContainer.bottomAnchor, constant: 16),
            commentsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            commentsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sendBtn.topAnchor.constraint(equalTo: commentsTableView.bottomAnchor, constant: 16),
            sendBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            sendBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sendBtn.widthAnchor.constraint(equalToConstant: 40),
            sendBtn.heightAnchor.constraint(equalToConstant: 40),
            
            message.topAnchor.constraint(equalTo: commentsTableView.bottomAnchor, constant: 16),
            message.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            message.leadingAnchor.constraint(equalTo: sendBtn.trailingAnchor, constant: 25),
            message.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            message.heightAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
