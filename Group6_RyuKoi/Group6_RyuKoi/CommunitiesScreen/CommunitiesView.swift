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
    
    //MARK: tableView for events...
    var tableViewEvents: UITableView!
    
    var titleBackground: UIView! // to be under the category label?
    var eventLabel: UILabel!
    var subLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)

        setupContentWrapper()
        setupTableViewEvents()
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
    
    func setupTableViewEvents(){
        tableViewEvents = UITableView()
        tableViewEvents.register(CommunitiesTableViewCell.self, forCellReuseIdentifier: "events")
        tableViewEvents.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewEvents)
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
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            // MARK: category background ...
            titleBackground.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 24),
            titleBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleBackground.heightAnchor.constraint(equalToConstant: 60),
            titleBackground.widthAnchor.constraint(equalToConstant: 220),

            // MARK: category label ...
            eventLabel.centerXAnchor.constraint(equalTo: titleBackground.centerXAnchor),
            eventLabel.centerYAnchor.constraint(equalTo: titleBackground.centerYAnchor),

            // MARK: sublabel under background ...
            subLabel.topAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableViewEvents.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            tableViewEvents.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            tableViewEvents.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            tableViewEvents.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8)
        ])
    }
    
    //MARK: initializing constraints...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
