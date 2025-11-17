import UIKit

enum MartialArt {
    case taekwondo
    case karate
    case boxing
    case mma
    case wrestling
    case judo
    case bjj
    case kickboxing
    case muayThai
    
    var color: UIColor {
        switch self {
        case .taekwondo:
            return UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0) // Blue
        case .karate:
            return UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0) // Red
        case .boxing:
            return UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0) // Gold
        case .mma:
            return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0) // Dark Gray
        case .wrestling:
            return UIColor(red: 0.6, green: 0.2, blue: 0.8, alpha: 1.0) // Purple
        case .judo:
            return UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0) // Green
        case .bjj:
            return UIColor(red: 0.1, green: 0.3, blue: 0.5, alpha: 1.0) // Dark Blue
        case .kickboxing:
            return UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 1.0) // Orange
        case .muayThai:
            return UIColor(red: 0.8, green: 0.2, blue: 0.4, alpha: 1.0) // Pink/Red
        }
    }
}

struct Lesson {
    let title: String
    let progressState: LessonProgressState
    let martialArt: MartialArt
}

class LessonViewController: TopNavigationViewController {  // ← Change this line
    
    // MARK: - Properties
    private let lessonView = LessonView()
    
    private var lessons: [Lesson] = [
        Lesson(title: "Basic Kicks", progressState: .notStarted, martialArt: .taekwondo),
        Lesson(title: "Punching Form", progressState: .notStarted, martialArt: .karate),
        Lesson(title: "Footwork", progressState: .inProgress, martialArt: .boxing),
        Lesson(title: "Ground Game", progressState: .inProgress, martialArt: .bjj),
        Lesson(title: "Throws", progressState: .completed, martialArt: .judo),
        Lesson(title: "Clinch Work", progressState: .retry, martialArt: .muayThai)
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()  // ← This calls TopNavigationViewController's viewDidLoad
        
        view.addSubview(lessonView.backButton)
        view.addSubview(lessonView.titleLabel)
        view.addSubview(lessonView.collectionView)
        
        setupConstraints()
        setupCollectionView()
        setupBackButton()
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
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension LessonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LessonCardCell.identifier,
            for: indexPath
        ) as? LessonCardCell else {
            return UICollectionViewCell()
        }
        
        let lesson = lessons[indexPath.item]
        cell.configure(title: lesson.title, progressState: lesson.progressState, color: lesson.martialArt.color)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LessonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected lesson at index: \(indexPath.item)")
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
