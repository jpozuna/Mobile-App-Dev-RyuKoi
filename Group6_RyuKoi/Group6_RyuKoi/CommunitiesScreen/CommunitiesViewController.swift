//
//  CommunitiesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CommunitiesViewController: UIViewController {
    let communitiesScreen = CommunitiesView()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var eventsList: [Event] = []
    
    override func loadView() {
        view = communitiesScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.database.collection("event")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.eventsList = documents.compactMap { try? $0.data(as: Event.self) }
                self.communitiesScreen.collectionViewEvents.reloadData()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        //MARK: patching the table view delegate and datasource to controller...
        communitiesScreen.collectionViewEvents.delegate = self
        communitiesScreen.collectionViewEvents.dataSource = self
        
        communitiesScreen.addbtn.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        
        communitiesScreen.setAccountTarget(self, action: #selector(openProfile))
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func addEvent() {
        let addEventScreen = AddEventViewController()
        navigationController?.pushViewController(addEventScreen, animated: true)
    }
}

extension CommunitiesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:CommunitiesEventCell.identifier,
            for: indexPath
        ) as! CommunitiesEventCell

        let event = eventsList[indexPath.row]
        //let isFavorited = favoritesList.contains(lesson.title)
        cell.configure(with: event)
        
        // registering if notif is tapped
        cell.notifIcon.tag = indexPath.row
        cell.notifIcon.addTarget(self, action: #selector(getNotification(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func getNotification(_ sender: UIButton) {
        let row = sender.tag
        let event = eventsList[row]
        
        guard let user = Auth.auth().currentUser else { return }
        
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
                    self.showDropdownAlert(message: "You are now following this event!")
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventScreen = CommunityViewController()
        eventScreen.selectedEvent = eventsList[indexPath.item]
        navigationController?.pushViewController(eventScreen, animated: true)
    }
    
    //MARK: cell layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let insets = layout.sectionInset
        let spacing = layout.minimumInteritemSpacing
        
        let totalSpacing = insets.left + insets.right + spacing
        let width = (collectionView.bounds.width - totalSpacing) / 2
        
        return CGSize(width: width, height: 150)
    }
}
