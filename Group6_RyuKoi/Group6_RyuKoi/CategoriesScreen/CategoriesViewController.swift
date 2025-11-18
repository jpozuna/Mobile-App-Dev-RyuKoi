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
    
    //MARK: list to display the category names in the TableView...
    let categoryNames = ["Taekwondo", "Karate", "Boxing", "Jujutsu", "Other"]
    
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

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categories", for: indexPath) as! CategoriesTableViewCell
        cell.categoryLabel.text = categoryNames[indexPath.row]
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeController = HomeViewController()
        homeController.receivedCategory = self.categoryNames[indexPath.row]
        navigationController?.pushViewController(homeController, animated: true)
    }
}
