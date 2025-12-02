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

class HomeViewController: UIViewController {
    let homeScreen = HomeView()
    var receivedCategory = "" // To be changed with the category...
    let lessons: [Lesson] = [
        Lesson(title: "Basic Kicks", progressState: .notStarted, progressPercentage: 0, martialArt: .taekwondo, favorite: false),
        Lesson(title: "Punching Form", progressState: .notStarted, progressPercentage: 0, martialArt: .karate, favorite: false),
        Lesson(title: "Footwork", progressState: .inProgress, progressPercentage: 50, martialArt: .boxing, favorite: false),
        Lesson(title: "Ground Game", progressState: .inProgress, progressPercentage: 50, martialArt: .bjj, favorite: false),
        Lesson(title: "Throws", progressState: .completed, progressPercentage: 100, martialArt: .judo, favorite: false),
        Lesson(title: "Clinch Work", progressState: .retry, progressPercentage: 0, martialArt: .muayThai, favorite: false)
    ]
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        homeScreen.categoryLabel.text = receivedCategory
        
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
        return lessons.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeLessonCell",
            for: indexPath
        ) as! HomeLessonCell

        cell.configure(with: lessons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lesson = lessons[indexPath.row]

        let lessonToPass = Lesson(
            title: lesson.title,
            progressState: lesson.progressState,
            progressPercentage: lesson.progressPercentage,
            martialArt: lesson.martialArt,
            favorite: lesson.favorite
        )

        let lessonViewController = LessonViewController()
        lessonViewController.selectedLesson = lessonToPass

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
