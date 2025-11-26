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
    let events = ["event", "event", "event", "event", "event", "event"]
    
    override func loadView() {
        view = communitiesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        //MARK: patching the table view delegate and datasource to controller...
        communitiesScreen.collectionViewEvents.delegate = self
        communitiesScreen.collectionViewEvents.dataSource = self
        
        communitiesScreen.setAccountTarget(self, action: #selector(openProfile))
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}

extension CommunitiesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunitiesEventCell.identifier, for: indexPath) as! CommunitiesEventCell
        cell.eventLabel.text = events[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Event: \(events[indexPath.item])")
        let eventScreen = CommunityViewController()
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
