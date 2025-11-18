//
//  CategoriesView.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CategoriesView: UIView {
    //MARK: scrollview for scrolling
    var contentWrapper:UIScrollView!
    
    //MARK: tableView for categories...
    var tableViewCategories: UITableView!
    
    var appTitleLabel: UILabel!
    var screenLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)

        setupContentWrapper()
        setupTableViewCategories()
        appTitleLabel = setupLabel("RyuKoi", 30)
        screenLabel = setupLabel("Home categories", 16)
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupTableViewCategories(){
        tableViewCategories = UITableView()
        tableViewCategories.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "categories")
        tableViewCategories.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewCategories)
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
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            appTitleLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 10),
            appTitleLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            
            screenLabel.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 5),
            screenLabel.leadingAnchor.constraint(equalTo: appTitleLabel.leadingAnchor),
            
            tableViewCategories.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 10),
            tableViewCategories.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            tableViewCategories.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            tableViewCategories.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8)
        ])
    }

    //MARK: initializing constraints...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
