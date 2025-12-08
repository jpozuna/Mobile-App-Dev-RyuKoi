//
//  ProfileViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    let profileScreen = ProfileView()
    var currentUser:FirebaseAuth.User?

    override func loadView() {
        view = profileScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        if let user = Auth.auth().currentUser {
            profileScreen.name.text = user.displayName ?? "No Name"
            profileScreen.email.text = "Email: \(user.email ?? "")"
        }
        
        
        profileScreen.notificationTableView.dataSource = self
        profileScreen.notificationTableView.delegate = self
        
        profileScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        profileScreen.logout.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutTapped() {
        let alert = UIAlertController(
            title: "Logging out!",
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { _ in
            do {
                try Auth.auth().signOut()
                
                DispatchQueue.main.async {
                    let loginScreen = LoginViewController()
                    let nav = UINavigationController(rootViewController: loginScreen)
                    nav.modalPresentationStyle = .fullScreen
                    
                    UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows
                        .first?.rootViewController = nav
                }
                
            } catch {
                print("Logout error:", error)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
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


