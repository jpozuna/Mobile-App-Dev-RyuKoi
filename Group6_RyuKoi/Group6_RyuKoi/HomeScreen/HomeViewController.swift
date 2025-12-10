//
//  HomeViewController.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory: Categories?
    let database = Firestore.firestore()
    var favoritesList: [String] = []
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
        fetchUserFavorites()
    }
    
    func fetchUserFavorites() {
        guard let email = Auth.auth().currentUser?.email else { return }

        database.collection("users").document(email).getDocument { snapshot, error in
            if let data = snapshot?.data(),
               let favs = data["favoriteLessons"] as? [String] {
                self.favoritesList = favs
                self.homeScreen.collectionViewLessons.reloadData()
            }
        }
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
        let isFavorited = favoritesList.contains(lesson.title)
        cell.configure(with: lesson, isFavorited: isFavorited)
        
        // registering if star is tapped
        cell.starIcon.tag = indexPath.row
        cell.starIcon.isSelected = isFavorited
        cell.starIcon.addTarget(self, action: #selector(handleStarTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func handleStarTapped(_ sender: UIButton) {
        let row = sender.tag
        let lesson = receivedCategory!.lesson[row]

        sender.isSelected.toggle()

        if sender.isSelected {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            addFavorite(title: lesson.title)
        } else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            removeFavorite(title: lesson.title)
        }
    }
    
    //MARK: Favorite lessons updated
    //this is done via adding the lesson title as a string to the user's favoriteLessons array
    
    func addFavorite(title: String) {
        guard let email = Auth.auth().currentUser?.email else { return }

        database.collection("users").document(email).updateData([
            "favoriteLessons": FieldValue.arrayUnion([title])
        ])
    }

    func removeFavorite(title: String) {
        guard let email = Auth.auth().currentUser?.email else { return }

        database.collection("users").document(email).updateData([
            "favoriteLessons": FieldValue.arrayRemove([title])
        ])
    }
    
    //MARK: selecting a lesson
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lessonViewController = LessonViewController()
        let selectedLesson = receivedCategory?.lesson[indexPath.row]
        lessonViewController.selectedLesson = selectedLesson
        navigationController?.pushViewController(lessonViewController, animated: true)
    }
    
    //MARK: lesson cell layout
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
