//
//  CommunitiesViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add plus button to event title label later...

import UIKit
import FirebaseFirestore

class CommunitiesViewController: UIViewController {
    let communitiesScreen = CommunitiesView()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunitiesEventCell.identifier, for: indexPath) as! CommunitiesEventCell
        cell.eventLabel.text = eventsList[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventScreen = CommunityViewController()
        eventScreen.selectedEvent = eventsList[indexPath.item]
        navigationController?.pushViewController(eventScreen, animated: true)
        // You can handle favorite toggles here or push to lesson detail
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 12) / 2 // 2 columns
        return CGSize(width: width, height: width)
    }
}
