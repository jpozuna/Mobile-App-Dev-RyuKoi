//
//  TopNavigationViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class TopNavigationViewController: UIViewController {
    let topNav = TopNavigationBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(topNav)
        topNav.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topNav.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topNav.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topNav.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topNav.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        topNav.account.addTarget(self, action: #selector(handleAccount), for: .touchUpInside)
    }
    
    @objc func handleAccount() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
