//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//
//MARK: TODO
// need to add ability to "heart" a lesson to add to favorites // changed some stuff with bottom nav bar??? dunno how it works.
// need to change table view to grid view for lessons//favorites//communities

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory: Categories?
    let database = Firestore.firestore()
    var favoritesList: [Lesson] = []
    var currentUser:FirebaseAuth.User?
    
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        homeScreen.categoryLabel.text = receivedCategory?.name.rawValue
        
        //MARK: patching the table view delegate and datasource to controller...
        homeScreen.collectionViewLessons.delegate = self
        homeScreen.collectionViewLessons.dataSource = self
        
        homeScreen.setAccountTarget(self, action: #selector(openProfile))
        homeScreen.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func backBtnTapped(){
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return receivedCategory?.lesson.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeLessonCell",
            for: indexPath
        ) as! HomeLessonCell
        
        let lesson = receivedCategory!.lesson[indexPath.row]
        cell.configure(with: lesson)
        cell.starIcon.tag = indexPath.row
        cell.starIcon.addTarget(self, action: #selector(handleStarTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func handleStarTapped(_ sender: UIButton) {
        let row = sender.tag
        guard let lesson = receivedCategory?.lesson[row] else { return }
        
        // Toggle the button state
        sender.isSelected.toggle()
                    
        // Update button image
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoritesList.append(receivedCategory!.lesson[row])
            updateFavoritesToUser()
            
        } else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func updateFavoritesToUser() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else { return }
            
        database.collection("users")
            .document(currentUserEmail)
            .updateData([
                "favoriteLessons": FieldValue.arrayUnion([favoritesList])
            ]) { error in
                if let error = error {
                    print("Failed to update favorites")
                } else {
                    print("updated fav")
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lessonViewController = LessonViewController()
        let selectedLesson = receivedCategory?.lesson[indexPath.row]
        lessonViewController.selectedLesson = selectedLesson
        navigationController?.pushViewController(lessonViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 3
        let width = (collectionView.bounds.width - totalSpacing) / 2
        
        return CGSize(width: width, height: 150)
    }
}
