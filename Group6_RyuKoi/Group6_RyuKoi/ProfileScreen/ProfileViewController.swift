//
//  ProfileViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    let profileScreen = ProfileView()
    var currentUser:FirebaseAuth.User?
    var notifications: [Notifications] = []
    
    
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
        
        loadUserNotifications()
        
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
    
    func loadUserNotifications() {
        guard let email = Auth.auth().currentUser?.email else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(email)
            .getDocument { document, error in
                
                if let data = document?.data(),
                   let notifArray = data["notifications"] as? [[String: Any]] {
                    
                    self.notifications = notifArray.compactMap { dict in
                        guard let title = dict["title"] as? String,
                              let message = dict["message"] as? String,
                              let timestamp = dict["date"] as? Timestamp else { return nil }
                        
                        return Notifications(
                            title: title,
                            message: message,
                            date: timestamp.dateValue()
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self.profileScreen.notificationTableView.reloadData()
                    }
                }
            }
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! TableViewNotificationCell
        let notif = notifications[indexPath.row]
        
        cell.eventName.text = notif.title
        cell.messageText.text = notif.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        cell.date.text = formatter.string(from: notif.date)
        
        return cell
    }
}


