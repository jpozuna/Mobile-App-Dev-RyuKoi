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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white // NEED TO CHANGE THIS LATER -- FIND SYSTEM
        
        setupContentWrapper()
        setupTableViewCategories()
        
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
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            tableViewCategories.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
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
