//
//  ProfileView.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class ProfileView: UIView {
    var backBtn: UIButton!
    var logout: UIButton!
    var image: UIImageView!
    var name: UILabel!
    var email: UILabel!
    var preferencesCollectionView: UICollectionView!
    var notificationLabel: UILabel!
    var notificationTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupBackBtn()
        setupLogoutBtn()
        setupImage()
        setupName()
        setupEmail()
        //setupPreferences()
        setupsetupNotificationLabel()
        setupNotificationTableView()
        initConstraints()
    }
    
    func setupBackBtn() {
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .label
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backBtn)
    }
    
    func setupLogoutBtn(){
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        
        logout = UIButton()
        logout.setImage(UIImage(systemName: "iphone.and.arrow.right.outward", withConfiguration: config), for: .normal)
        logout.tintColor = .label
        logout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logout)
    }
    
    func setupImage(){
        image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
    }
    
    func setupName(){
        name = UILabel()
        name.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func setupEmail(){
        email = UILabel()
        email.font = UIFont.systemFont(ofSize: 17)
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func setupsetupNotificationLabel(){
        notificationLabel = UILabel()
        notificationLabel.text = "Notifications"
        notificationLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(notificationLabel)
    }
    
    func setupNotificationTableView(){
        notificationTableView = UITableView()
        notificationTableView.register(TableViewNotificationCell.self, forCellReuseIdentifier: "notification")
        notificationTableView.backgroundColor = .clear
        notificationTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(notificationTableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            backBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            logout.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            logout.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            notificationLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            notificationLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            notificationTableView.topAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 10),
            notificationTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            notificationTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            notificationTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
