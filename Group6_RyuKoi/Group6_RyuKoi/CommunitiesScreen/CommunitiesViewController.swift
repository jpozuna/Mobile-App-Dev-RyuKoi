//
//  CommunitiesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add plus button to event title label later...

import UIKit

class CommunitiesViewController: UIViewController {
    let communitiesScreen = CommunitiesView()
    let navBar = TopNavigationBarView()
    let events = ["event", "event", "event", "event"]
    
    override func loadView() {
        view = communitiesScreen
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

extension CommunitiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath) as! CommunitiesTableViewCell
        
        let leftIndex = indexPath.row * 2
        let rightIndex = leftIndex + 1
        
        cell.leftLabel.text = events[leftIndex]
        
        if rightIndex < events.count {
            cell.rightEventView.isHidden = false
            cell.rightLabel.text = events[rightIndex]
        } else {
            // Hide right box if odd number of lessons
            cell.rightEventView.isHidden = true
        }
        
        return cell
    }
}
