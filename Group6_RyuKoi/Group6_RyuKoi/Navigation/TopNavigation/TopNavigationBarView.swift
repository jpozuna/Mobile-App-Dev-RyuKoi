//
//  TopNavigationBarView.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TopNavigationBarView: UIView {
    var logo: UIButton!
    var searchBar: UISearchBar!
    var filter: UIButton!
    var account: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        //self.backgroundColor = .gray.withAlphaComponent(0.2)
        setupLogo()
        setupSearchBar()
        setupFilter()
        setupAccount()
        initConstraints()
    }
    
    func setupLogo() {
        logo = UIButton(type: .custom)
        logo.setImage(UIImage(named: "Logo"), for: .normal)
        logo.imageView?.contentMode = .scaleAspectFit
        //logo.backgroundColor = .blue.withAlphaComponent(0.3)
        logo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logo)
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search lessons..."
        searchBar.backgroundImage = UIImage()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = UIColor(red: 1.0, green: 248/255, blue: 232/255, alpha: 1.0)
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
    }

    
    func setupFilter(){
        filter = UIButton(type: .system)
        filter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        filter.imageView?.contentMode = .scaleAspectFit
        filter.tintColor = .black
        filter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filter)
    }
    
    func setupAccount() {
        account = UIButton(type: .system)
        account.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        account.imageView?.contentMode = .scaleAspectFit
        account.tintColor = .black
        account.translatesAutoresizingMaskIntoConstraints = false
        addSubview(account)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 50),
            logo.heightAnchor.constraint(equalToConstant: 50),
            
            account.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            account.centerYAnchor.constraint(equalTo: centerYAnchor),
            account.widthAnchor.constraint(equalToConstant: 50),
            account.heightAnchor.constraint(equalToConstant: 50),
            
            filter.centerYAnchor.constraint(equalTo: centerYAnchor),
            filter.trailingAnchor.constraint(equalTo: account.leadingAnchor, constant: -10),
            filter.widthAnchor.constraint(equalToConstant: 50),
            filter.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.leadingAnchor.constraint(equalTo: logo.trailingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: filter.leadingAnchor),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
