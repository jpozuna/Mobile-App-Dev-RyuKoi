//
//  ProfileViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileScreen = ProfileView()
    //let notifications: [Notification] = []
    
    override func loadView() {
        view = profileScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
//        profileScreen.preferencesCollectionView.dataSource = self
//        profileScreen.preferencesCollectionView.delegate = self
        
        profileScreen.notificationTableView.dataSource = self
        profileScreen.notificationTableView.delegate = self
        
        profileScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        profileScreen.logout.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutTapped(){
        let loginScreen = LoginViewController()
        navigationController?.pushViewController(loginScreen, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! TableViewNotificationCell
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

//extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    var samplePreferences: [String] {
//        return ["Wrestle", "Karate", "Takewondo"]
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return samplePreferences.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: "token",
//            for: indexPath
//        ) as! PreferenceTokenCellCollectionViewCell
//        
//        cell.label.text = samplePreferences[indexPath.row]
//        return cell
//    }
//    
//    // Optional: dynamic token sizing
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let label = UILabel()
//        label.text = samplePreferences[indexPath.row]
//        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        label.sizeToFit()
//        
//        return CGSize(width: label.frame.width + 24, height: 32)
//    }
//}

