import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavoritesViewController: UIViewController {
    let favoritesScreen = FavoritesView()
    let database = Firestore.firestore()
    var favoritesList: [Lesson] = []
    
    override func loadView() {
        view = favoritesScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // Patch collection view delegate and datasource
        favoritesScreen.collectionViewFavorites.delegate = self
        favoritesScreen.collectionViewFavorites.dataSource = self
        
        favoritesScreen.setAccountTarget(self, action: #selector(openProfile))
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    private func loadFavorites() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("❌ No user logged in")
            favoritesList = []
            favoritesScreen.collectionViewFavorites.reloadData()
            favoritesScreen.updateEmptyState(true)
            return
        }
        
        print("🔷 Loading favorites for: \(userEmail)")
        
        // Load user's favorited lessons from Firebase - same location as HomeViewController
        database.collection("users")
            .document(userEmail)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("❌ Error loading favorites: \(error.localizedDescription)")
                    self.favoritesList = []
                    self.favoritesScreen.collectionViewFavorites.reloadData()
                    self.favoritesScreen.updateEmptyState(true)
                    return
                }
                
                guard let data = snapshot?.data(),
                      let favoriteTitles = data["favoriteLessons"] as? [String] else {
                    print("⚠️ No favorites found")
                    self.favoritesList = []
                    self.favoritesScreen.collectionViewFavorites.reloadData()
                    self.favoritesScreen.updateEmptyState(true)
                    return
                }
                
                print("✅ Found \(favoriteTitles.count) favorite titles: \(favoriteTitles)")
                
                // Filter mockCategories to get full lesson objects
                self.favoritesList = mockCategories
                    .flatMap { $0.lesson }
                    .filter { favoriteTitles.contains($0.title) }
                
                print("✅ Loaded \(self.favoritesList.count) favorite lessons")
                self.favoritesScreen.collectionViewFavorites.reloadData()
                self.favoritesScreen.updateEmptyState(self.favoritesList.isEmpty)
            }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteCardCell.identifier,
            for: indexPath
        ) as! FavoriteCardCell
        
        let lesson = favoritesList[indexPath.row]
        cell.lesson = lesson
        
        // Make the star icon tappable to remove from favorites
        cell.starIcon.isUserInteractionEnabled = true
        
        // Remove any existing gesture recognizers
        cell.starIcon.gestureRecognizers?.forEach { cell.starIcon.removeGestureRecognizer($0) }
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        cell.starIcon.tag = indexPath.row
        cell.starIcon.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    @objc func starTapped(_ gesture: UITapGestureRecognizer) {
        guard let starIcon = gesture.view else { return }
        let row = starIcon.tag
        guard row < favoritesList.count else { return }
        
        let lesson = favoritesList[row]
        
        // Show confirmation alert
        let alert = UIAlertController(
            title: "Remove from Favorites?",
            message: "Remove \"\(lesson.title)\" from your favorites?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.removeFavorite(lesson: lesson)
        })
        
        present(alert, animated: true)
    }
    
    private func removeFavorite(lesson: Lesson) {
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
        database.collection("users")
            .document(userEmail)
            .updateData([
                "favoriteLessons": FieldValue.arrayRemove([lesson.title])
            ]) { error in
                if let error = error {
                    print("❌ Error removing favorite: \(error.localizedDescription)")
                } else {
                    print("✅ Removed from favorites: \(lesson.title)")
                    // The snapshot listener will automatically update the UI
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lessonScreen = LessonViewController()
        lessonScreen.selectedLesson = favoritesList[indexPath.item]
        navigationController?.pushViewController(lessonScreen, animated: true)
    }
    
    // Cell layout - 2 column grid
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let insets = layout.sectionInset
        let spacing = layout.minimumInteritemSpacing
        
        let totalSpacing = insets.left + insets.right + spacing
        let width = (collectionView.bounds.width - totalSpacing) / 2
        
        return CGSize(width: width, height: 180)
    }
}
