// MARK: - Add this to your LessonViewController.swift

import UIKit
import FirebaseAuth

class LessonViewController: UIViewController {
    let lessonScreen = LessonView()
    var selectedLesson: Lesson?
    
    // Add favorite button
    var favoriteButton: UIButton!
    var isFavorited: Bool = false
    
    override func loadView() {
        self.view = lessonScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .never
        
        lessonScreen.descriptionLabel.text = selectedLesson?.description
        lessonScreen.lessonName.text = selectedLesson?.title
        
        lessonScreen.setAccountTarget(self, action: #selector(openProfile))
        lessonScreen.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        lessonScreen.startBtn.addTarget(self, action: #selector(startBtnPressed), for: .touchUpInside)
        
        // Setup favorite button
        setupFavoriteButton()
        checkFavoriteStatus()
    }
    
    // MARK: - Favorite Button Setup
    
    func setupFavoriteButton() {
        favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        lessonScreen.addSubview(favoriteButton)
        
        // Position it (adjust to fit your design)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: lessonScreen.safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: lessonScreen.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    func checkFavoriteStatus() {
        guard let lesson = selectedLesson else { return }
        
        FavoritesManager.shared.checkIfFavorited(lessonTitle: lesson.title) { [weak self] isFavorited in
            self?.isFavorited = isFavorited
            self?.updateFavoriteButton()
        }
    }
    
    func updateFavoriteButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        let imageName = isFavorited ? "star.fill" : "star"
        let image = UIImage(systemName: imageName, withConfiguration: config)
        
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.tintColor = isFavorited ? .systemYellow : UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
    }
    
    @objc func favoriteButtonTapped() {
        guard let lesson = selectedLesson else {
            print("No lesson selected!")
            return
        }
        
        print("Star button tapped for: \(lesson.title)")
        
        // Disable button while processing
        favoriteButton.isEnabled = false
        
        FavoritesManager.shared.toggleFavorite(lessonTitle: lesson.title) { [weak self] success, nowFavorited in
            print("Toggle result: success=\(success), nowFavorited=\(nowFavorited)")
            
            guard let self = self else { return }
            
            // Re-enable button
            self.favoriteButton.isEnabled = true
            
            if success {
                self.isFavorited = nowFavorited
                self.updateFavoriteButton()
                
                // Show feedback
                let message = nowFavorited ? "Added to Favorites ⭐" : "Removed from Favorites"
                self.showQuickAlert(message: message)
            } else {
                // Show error
                let alert = UIAlertController(
                    title: "Error",
                    message: "Failed to update favorites. Please try again.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func showQuickAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        // Auto-dismiss after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }
    
    // MARK: - Navigation
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func backBtnPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func startBtnPressed(){
        let practiceScreen = PracticeViewController()
        practiceScreen.lesson = selectedLesson
        navigationController?.pushViewController(practiceScreen, animated: true)
    }
}
