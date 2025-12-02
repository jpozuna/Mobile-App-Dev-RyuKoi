import UIKit


class LessonViewController: TopNavigationViewController {
    
    var selectedLesson: Lesson?
        
    // MARK: - Properties
    private let lessonView = LessonView()
    
    // Add favorites button with star icon
    private let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedLesson = selectedLesson {
            lessonView.titleLabel.text = selectedLesson.title
        }
        
        view.addSubview(lessonView.backButton)
        view.addSubview(lessonView.titleLabel)
        view.addSubview(favoritesButton)  // Add favorites button
        view.addSubview(lessonView.collectionView)
        
        setupConstraints()
        setupCollectionView()
        setupBackButton()
        setupFavoritesButton()  // Setup favorites button
    }
    
    // MARK: - Setup
    private func setupConstraints() {
        lessonView.backButton.translatesAutoresizingMaskIntoConstraints = false
        lessonView.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lessonView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lessonView.backButton.topAnchor.constraint(equalTo: topNav.bottomAnchor, constant: 10),
            lessonView.backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonView.backButton.widthAnchor.constraint(equalToConstant: 30),
            lessonView.backButton.heightAnchor.constraint(equalToConstant: 30),
            
            lessonView.titleLabel.centerYAnchor.constraint(equalTo: lessonView.backButton.centerYAnchor),
            lessonView.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Favorites button on the right side with star icon
            favoritesButton.centerYAnchor.constraint(equalTo: lessonView.backButton.centerYAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favoritesButton.widthAnchor.constraint(equalToConstant: 30),
            favoritesButton.heightAnchor.constraint(equalToConstant: 30),
            
            lessonView.collectionView.topAnchor.constraint(equalTo: lessonView.titleLabel.bottomAnchor, constant: 20),
            lessonView.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonView.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lessonView.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        lessonView.collectionView.delegate = self
        lessonView.collectionView.dataSource = self
    }
    
    private func setupBackButton() {
        lessonView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupFavoritesButton() {
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        let favoritesVC = FavoritesViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToPractices(with lesson: Lesson) {
        let practicesVC = PracticeViewController()
        practicesVC.selectedLesson = lesson
        navigationController?.pushViewController(practicesVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension LessonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LessonCardCell.identifier,
            for: indexPath
        ) as? LessonCardCell else {
            return UICollectionViewCell()
        }
        
        //let lesson = lessons[indexPath.item]
        //cell.configure(title: lesson.title, progressState: lesson.progressState, color: lesson.martialArt.color)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LessonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedLesson = lessons[indexPath.item]
//        navigateToPractices(with: selectedLesson)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LessonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.bounds.width - padding
        let itemWidth = availableWidth / 2
        
        return CGSize(width: itemWidth, height: 180)
    }
}
