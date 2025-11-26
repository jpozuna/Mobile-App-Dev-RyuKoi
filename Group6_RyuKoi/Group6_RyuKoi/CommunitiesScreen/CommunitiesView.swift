//
//  CommunitiesView.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CommunitiesView: UIView {
    //MARK: scrollview for scrolling???
    var contentWrapper:UIScrollView!
    
    var navBar: TopNavigationBarView!
    
    //MARK: tableView for events...
    var collectionViewEvents: UICollectionView!
    
    var titleBackground: UIView! // to be under the category label?
    var eventLabel: UILabel!
    var subLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)

        setupContentWrapper()
        setupNavBar()
        setupCollectionView()
        setupRect()
        eventLabel = setupLabel("Events", 30)
        subLabel = setupLabel("In the community", 16)
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        collectionViewEvents = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewEvents.translatesAutoresizingMaskIntoConstraints = false
        collectionViewEvents.backgroundColor = .clear
        collectionViewEvents.register(CommunitiesEventCell.self, forCellWithReuseIdentifier: "CommunityEventCell")
        self.addSubview(collectionViewEvents)
    }
    
    func setupRect() {
        titleBackground = UIView()
        titleBackground.translatesAutoresizingMaskIntoConstraints = false
        titleBackground.backgroundColor = UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.67)
        titleBackground.layer.cornerRadius = 12
        self.addSubview(titleBackground)
    }
    
    func setupLabel(_ label: String, _ size: CGFloat)->UILabel {
        let lab = UILabel()
        lab.text = label
        lab.font = UIFont.systemFont(ofSize: size)
        lab.textColor = .black
        lab.textAlignment = .center
        lab.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lab)
        return lab
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            /*
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            */
            
            navBar.topAnchor.constraint(equalTo: self.topAnchor ,constant: 70),
            navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            // MARK: category background ...
            titleBackground.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10), // may have to change??
            titleBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleBackground.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleBackground.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleBackground.heightAnchor.constraint(equalToConstant: 60),

            // MARK: category label ...
            eventLabel.centerXAnchor.constraint(equalTo: titleBackground.centerXAnchor),
            eventLabel.centerYAnchor.constraint(equalTo: titleBackground.centerYAnchor),

            // MARK: sublabel under background ...
            subLabel.topAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            collectionViewEvents.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            collectionViewEvents.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionViewEvents.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionViewEvents.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
    
    
    
    //MARK: initializing constraints...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
