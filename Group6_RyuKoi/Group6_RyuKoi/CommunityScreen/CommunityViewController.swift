//
//  CommunityViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit

class CommunityViewController: UIViewController {
    let communityScreen = CommunityView()
    
    override func loadView() {
        view = communityScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        communityScreen.setAccountTarget(self, action: #selector(openProfile))
        
        communityScreen.commentsTableView.dataSource = self
        communityScreen.commentsTableView.delegate = self
        
        communityScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }

    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! TableViewCommentCell
        //        cell.labelTitle.text = expenses[indexPath.row].title
        //        if let uwAmount = expenses[indexPath.row].amount{
        //            cell.labelAmount.text = "Cost: $\(uwAmount)"
        //        }
        //        if let uwType = expenses[indexPath.row].type{
        //            cell.labelType.text = "Type: \(uwType)"
        //        }
        return cell
    }
}
