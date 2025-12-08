//
//  AddEventViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/7/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddEventViewController: UIViewController {
    let addEventScreen = AddEventView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    var eventList = [Event]()
    
    override func loadView() {
        view = addEventScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        addEventScreen.setAccountTarget(self, action: #selector(openProfile))
        addEventScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        addEventScreen.submitBtn.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func onSubmitButtonTapped() {
        guard
            let name = addEventScreen.titleTextField.text, !name.isEmpty,
            let bio = addEventScreen.descriptionTextField.text, !bio.isEmpty,
            let date = addEventScreen.dateTextField.text, !date.isEmpty,
            let time = addEventScreen.timeTextField.text, !time.isEmpty,
            let organizer = Auth.auth().currentUser?.email
        else {
            emptyAlert()
            return
        }
        
        let newEvent = Event(name: name, bio: bio, organizer: organizer, date: date, time: time, comments: [])
        saveEventToFireStore(event: newEvent, userEmail: organizer.lowercased())
    }
    
    func emptyAlert(){
        let alert = UIAlertController(
            title: "Feilds cannot be empty",
            message: "All feilds need to be filled out.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    func saveEventToFireStore(event: Event, userEmail: String) {
        database.collection("event")
            .document(event.name)
            .setData([
                "name": event.name,
                "bio": event.bio,
                "organizer": userEmail,
                "date": event.date,
                "time": event.time,
                "comments": []
            ]){ error in
                if error != nil {
                    print("Error adding event to Firestore")
                } else {
                    print("Event successfully added to database.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
    }
}
