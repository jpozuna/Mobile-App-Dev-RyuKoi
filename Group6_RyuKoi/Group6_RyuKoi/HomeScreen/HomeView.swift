//
//  HomeView.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class HomeView: UIView {
    //MARK: scrollview for scrolling???
    var contentWrapper:UIScrollView!
    
    //MARK: tableView for lessons...
    var tableViewLessons: UITableView!
    
    var categoryBackground: UIView! // to be under the category label?
    var categoryLabel: UILabel!
    var subLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)

        setupContentWrapper()
        setupTableViewCategories()
        setupRect()
        categoryLabel = setupLabel("Taekwondo", 30) // due to change...temporary
        subLabel = setupLabel("Lesson journey", 16)
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupTableViewCategories(){
        tableViewLessons = UITableView()
        tableViewLessons.register(HomeTableViewCell.self, forCellReuseIdentifier: "lessons")
        tableViewLessons.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewLessons)
    }
    
    func setupRect() {
        categoryBackground = UIView()
        categoryBackground.translatesAutoresizingMaskIntoConstraints = false
        categoryBackground.backgroundColor = UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.67)
        categoryBackground.layer.cornerRadius = 12
        self.addSubview(categoryBackground)
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
            
            // MARK: category background ...
            categoryBackground.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 24),
            categoryBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryBackground.heightAnchor.constraint(equalToConstant: 60),
            categoryBackground.widthAnchor.constraint(equalToConstant: 220),

            // MARK: category label ...
            categoryLabel.centerXAnchor.constraint(equalTo: categoryBackground.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: categoryBackground.centerYAnchor),

            // MARK: sublabel under background ...
            subLabel.topAnchor.constraint(equalTo: categoryBackground.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableViewLessons.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            tableViewLessons.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            tableViewLessons.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            tableViewLessons.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8) // maybe!
        ])
    }
    
    //MARK: initializing constraints...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
