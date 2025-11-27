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

struct HomeLesson {
    let id: String
    let title: String
    let progressPercentage: Int
    let martialArt: String
    let isFavorite: Bool
}


class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory = "" // To be changed with the category...
    private var homeLessons: [HomeLesson] = []
    
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        homeScreen.categoryLabel.text = receivedCategory
        
        homeScreen.collectionViewLessons.delegate = self
        homeScreen.collectionViewLessons.dataSource = self
        
        homeLessons = loadMockLessons()
        
        homeScreen.collectionViewLessons.reloadData()
        
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
    
    private func loadMockLessons() -> [HomeLesson] {
        return [
            HomeLesson(id: "1", title: "Basic Punches", progressPercentage: 20, martialArt: "Karate", isFavorite: false),
            HomeLesson(id: "2", title: "Roundhouse Kick", progressPercentage: 0, martialArt: "Taekwondo", isFavorite: false),
            HomeLesson(id: "3", title: "Breakfall Basics", progressPercentage: 45, martialArt: "Judo", isFavorite: false),
            HomeLesson(id: "4", title: "Guard Escape", progressPercentage: 70, martialArt: "BJJ", isFavorite: false),
            HomeLesson(id: "5", title: "Blocking Drills", progressPercentage: 55, martialArt: "Karate", isFavorite: false),
            HomeLesson(id: "6", title: "Spinning Kick", progressPercentage: 10, martialArt: "Taekwondo", isFavorite: false)
        ]
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeLessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeLessonCell",
            for: indexPath
        ) as! HomeLessonCell
        
        let lesson = homeLessons[indexPath.row]
        cell.configure(with: lesson)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let lesson = lessons[indexPath.row]
        
        //        let lessonToPass = Lesson(
        //            title: lesson.title,
        //            progressState: lesson.progressState,
        //            progressPercentage: lesson.progressPercentage,
        //            martialArt: lesson.martialArt,
        //            favorite: lesson.favorite
        //        )
        
        let lessonViewController = LessonViewController()
        //lessonViewController.selectedLesson = lessonToPass
        
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
