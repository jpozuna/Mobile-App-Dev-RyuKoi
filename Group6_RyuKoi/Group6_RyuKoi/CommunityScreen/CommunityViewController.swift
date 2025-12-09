//
//  CommunityViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CommunityViewController: UIViewController {
    let communityScreen = CommunityView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var selectedEvent:  Event?
    
    override func loadView() {
        view = communityScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        communityScreen.commentsTableView.separatorStyle = .none
        
        communityScreen.setAccountTarget(self, action: #selector(openProfile))
        
        communityScreen.commentsTableView.dataSource = self
        communityScreen.commentsTableView.delegate = self
        
        communityScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        communityScreen.sendBtn.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        communityScreen.notificationBtn.addTarget(self, action: #selector(getNotification), for: .touchUpInside)
        
        communityScreen.eventName.text = selectedEvent?.name
        communityScreen.date.text = selectedEvent?.date
        communityScreen.bio.text = selectedEvent?.bio
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func addComment() {
        guard let user = Auth.auth().currentUser,
              let message = communityScreen.message.text,
              let event = selectedEvent else { return }
        
        let timestamp = Timestamp(date: Date())
        
        let commentData: [String: Any] = [
            "userName": user.displayName ?? "Unknown",
            "text": message,
            "Date": timestamp
        ]
        
        let eventRef = database.collection("event").document(event.name)
        
        // 1. Add comment to event
        eventRef.updateData([
            "comments": FieldValue.arrayUnion([commentData])
        ]) { error in
            if let error = error {
                print("Error adding comment: \(error)")
                return
            }
            
            print("Comment added successfully.")
            
            // 2. Fetch followers
            eventRef.getDocument { document, error in
                if let doc = document, let data = doc.data(),
                   let followers = data["followers"] as? [String] {
                    
                    self.sendNotificationToFollowers(
                        followers: followers,
                        eventName: event.name,
                        message: message
                    )
                }
            }
            
            // Update local list
            let newComment = Comment(
                userName: user.displayName ?? "Unknown",
                text: message,
                Date: timestamp.dateValue()
            )
            
            self.selectedEvent?.comments.append(newComment)
            self.communityScreen.commentsTableView.reloadData()
            self.communityScreen.message.text = ""
        }
    }
    
    
    @objc func getNotification() {
        guard let user = Auth.auth().currentUser,
              let event = selectedEvent else { return }
        
        let userEmail = user.email ?? ""
        
        database.collection("event")
            .document(event.name)
            .updateData([
                "followers": FieldValue.arrayUnion([userEmail])
            ]) { error in
                if let error = error {
                    print("Error following event: \(error)")
                } else {
                    print("User will now receive notifications for this event.")
                }
            }
    }
    
    func sendNotificationToFollowers(followers: [String], eventName: String, message: String) {
        let timestamp = Timestamp(date: Date())

        let notification: [String: Any] = [
            "title": "New comment on \(eventName)",
            "message": message,
            "date": timestamp
        ]

        for email in followers {
            database.collection("users")
                .document(email)
                .updateData([
                    "notifications": FieldValue.arrayUnion([notification])
                ]) { error in
                    if let error = error {
                        print("Failed to notify \(email): \(error)")
                    } else {
                        print("Notification delivered to \(email)")
                    }
                }
        }
    }

}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEvent?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! TableViewCommentCell
        cell.name.text = selectedEvent?.comments[indexPath.row].userName
        if let message = selectedEvent?.comments[indexPath.row].text{
            cell.comment.text = message
        }
        if let date = selectedEvent?.comments[indexPath.row].Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy h:mm a"
            cell.date.text = formatter.string(from: date)
        }
        return cell
    }
}
