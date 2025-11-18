//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add ability to "heart" a lesson to add to favorites

import UIKit

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    let navBar = TopNavigationBarView()
    var receivedCategory = "" // To be changed with the category...
    let lessons = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4"]
    
    override func loadView() {
        view = homeScreen
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessons", for: indexPath) as! HomeTableViewCell
        
        let leftIndex = indexPath.row * 2
        let rightIndex = leftIndex + 1
        
        cell.leftLabel.text = lessons[leftIndex]
        
        if rightIndex < lessons.count {
            cell.rightLessonView.isHidden = false
            cell.rightLabel.text = lessons[rightIndex]
        } else {
            // Hide right box if odd number of lessons
            cell.rightLessonView.isHidden = true
        }
        
        return cell
    }
}
