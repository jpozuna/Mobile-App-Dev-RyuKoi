//
//  CategoriesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CategoriesViewController: UIViewController {
    let categoriesScreen = CategoriesView()
    let navBar = TopNavigationBarView()
    
    override func loadView() {
        view = categoriesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.hidesBackButton = true
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        navBar.account.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
