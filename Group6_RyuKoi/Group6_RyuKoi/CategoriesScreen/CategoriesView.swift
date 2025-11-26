//
//  CategoriesView.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CategoriesView: UIView {
    var navBar: TopNavigationBarView!
    var tableViewCategories: UITableView!
    var appTitleLabel: UILabel!
    var screenLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupNavBar()
        setupTableViewCategories()
        appTitleLabel = setupLabel("RyuKoi", 30)
        screenLabel = setupLabel("Home categories", 16)
        initConstraints()
    }
    
    /*
     func setupContentWrapper(){
     contentWrapper = UIScrollView()
     contentWrapper.translatesAutoresizingMaskIntoConstraints = false
     self.addSubview(contentWrapper)
     }*/
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        //navBar.backgroundColor = .red.withAlphaComponent(0.3)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupTableViewCategories(){
        tableViewCategories = UITableView()
        tableViewCategories.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "categories")
        tableViewCategories.translatesAutoresizingMaskIntoConstraints = false
        tableViewCategories.backgroundColor = .clear
        //contentWrapper.addSubview(tableViewCategories)
        self.addSubview(tableViewCategories)
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
            
            appTitleLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            appTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            screenLabel.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 5),
            screenLabel.leadingAnchor.constraint(equalTo: appTitleLabel.leadingAnchor),
            
            tableViewCategories.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 10),
            tableViewCategories.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewCategories.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewCategories.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
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
