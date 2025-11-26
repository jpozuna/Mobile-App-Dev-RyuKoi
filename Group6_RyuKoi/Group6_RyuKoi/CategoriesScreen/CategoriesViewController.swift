//
//  CategoriesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class CategoriesViewController: UIViewController {
    //MARK: list to display the category names in the TableView...
    let categoryNames = ["Taekwondo", "Karate", "Boxing", "Jujutsu", "Other"]
    let categoriesScreen = CategoriesView()
    
    override func loadView() {
        view = categoriesScreen
    }
    
    // help with the navBar Layout
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        navigationController?.setNavigationBarHidden(true, animated: animated)
    //    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        navigationController?.setNavigationBarHidden(false, animated: animated)
    //    }
    
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
