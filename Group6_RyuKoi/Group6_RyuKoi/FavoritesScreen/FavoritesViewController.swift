//
//  FavoritesViewController.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private let favoritesView = FavoritesView()
    private var favoritesList: [FavoriteLesson] = []
    
    // MARK: - Lifecycle
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadFavorites()
        
        favoritesView.setAccountTarget(self, action: #selector(openProfile))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload favorites when screen appears in case they changed
        loadFavorites()
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        favoritesView.collectionView.delegate = self
        favoritesView.collectionView.dataSource = self
    }
    
    // MARK: - Data Loading
    private func loadFavorites() {
        // TODO: Replace with actual data loading from UserDefaults or a data manager
        // For now, using mock data to demonstrate the UI
        favoritesList = loadMockFavorites()
        
        // Show empty state if no favorites
        favoritesView.showEmptyState(favoritesList.isEmpty)
        favoritesView.collectionView.reloadData()
    }
    
    private func loadMockFavorites() -> [FavoriteLesson] {
        // Mock data for testing with varying progress levels
        return [
            FavoriteLesson(id: "1", title: "Basic Punching Technique", progressPercentage: 100),
            FavoriteLesson(id: "2", title: "Roundhouse Kick", progressPercentage: 75),
            FavoriteLesson(id: "3", title: "Guard Passing", progressPercentage: 45),
            FavoriteLesson(id: "4", title: "Front Kick Form", progressPercentage: 100),
            FavoriteLesson(id: "5", title: "Defensive Stance", progressPercentage: 60),
            FavoriteLesson(id: "6", title: "Combination Drills", progressPercentage: 20)
        ]
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCardCell", for: indexPath) as? FavoriteCardCell else {
            return UICollectionViewCell()
        }
        
        let lesson = favoritesList[indexPath.row]
        cell.configure(with: lesson, animated: true)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLesson = favoritesList[indexPath.row]
        print("Selected favorite lesson: \(selectedLesson.title)")
        
        // TODO: Navigate to lesson detail screen
        // Example: navigationController?.pushViewController(LessonDetailViewController(lesson: selectedLesson), animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.bounds.width - (padding * 3) // Left, right, and middle padding
        let cellWidth = availableWidth / 2
        let cellHeight: CGFloat = 200 // Taller to accommodate progress bar
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
