import UIKit

// MARK: - Lesson Progress State
enum LessonProgressState {
    case notStarted
    case inProgress
    case completed
    case retry
}

// MARK: - Lesson Card
class LessonCard: UIView {
    
    private let progressIconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.0
        progressView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        progressView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var progressState: LessonProgressState = .notStarted {
        didSet {
            updateProgressIcon()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        layer.cornerRadius = 20
        
        progressStackView.addArrangedSubview(progressIconView)
        progressStackView.addArrangedSubview(progressLabel)
        progressStackView.addArrangedSubview(progressBar)
        
        addSubview(progressStackView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            progressStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            progressStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            progressIconView.widthAnchor.constraint(equalToConstant: 20),
            progressIconView.heightAnchor.constraint(equalToConstant: 20),
            
            progressBar.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        updateProgressIcon()
    }
    
    private func updateProgressIcon() {
        switch progressState {
        case .notStarted:
            progressIconView.image = UIImage(systemName: "star")
        case .inProgress:
            progressIconView.image = nil
        case .completed:
            progressIconView.image = UIImage(systemName: "checkmark")
        case .retry:
            progressIconView.image = UIImage(systemName: "arrow.clockwise")
        }
    }
    
    func configure(title: String, progressState: LessonProgressState, color: UIColor) {
        titleLabel.text = title
        self.progressState = progressState
        backgroundColor = color.withAlphaComponent(0.3)
        progressBar.progressTintColor = color
        
        // Update progress bar based on state
        switch progressState {
        case .notStarted:
            progressBar.progress = 0.0
        case .inProgress:
            progressBar.progress = 0.5
        case .completed:
            progressBar.progress = 1.0
        case .retry:
            progressBar.progress = 0.75
        }
    }
}

// MARK: - Lesson Card Cell
class LessonCardCell: UICollectionViewCell {
    static let identifier = "LessonCardCell"
    
    private let lessonCard: LessonCard = {
        let card = LessonCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(lessonCard)
        
        NSLayoutConstraint.activate([
            lessonCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            lessonCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lessonCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lessonCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String, progressState: LessonProgressState, color: UIColor) {
        lessonCard.configure(title: title, progressState: progressState, color: color)
    }
}

// MARK: - Lesson View
class LessonView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lesson Library"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LessonCardCell.self, forCellWithReuseIdentifier: LessonCardCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
