//
//  CategoriesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit
import FirebaseAuth

class CategoriesViewController: UIViewController {
    //MARK: list to display the category names in the TableView...
    var categoryNames = ["Taekwondo", "Karate", "Boxing", "Jujutsu", "Other"]
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let categoriesScreen = CategoriesView()
    
    override func loadView() {
        view = categoriesScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .never
        
        // remove separator line between cells
        categoriesScreen.tableViewCategories.separatorStyle = .none
        
        //MARK: patching the table view delegate and datasource to controller...
        categoriesScreen.tableViewCategories.delegate = self
        categoriesScreen.tableViewCategories.dataSource = self
        
        categoriesScreen.setAccountTarget(self, action: #selector(openProfile))
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categories", for: indexPath) as! CategoriesTableViewCell
        cell.categoryLabel.text = mockCategories[indexPath.row].name.rawValue
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeController = HomeViewController()
        homeController.receivedCategory = mockCategories[indexPath.row]
        navigationController?.pushViewController(homeController, animated: true)
    }
}
