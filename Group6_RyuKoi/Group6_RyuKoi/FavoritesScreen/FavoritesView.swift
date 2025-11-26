//
//  FavoritesView.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//
import UIKit

class FavoritesView: UIView {
    
    // MARK: - UI Components
    private let navBar: TopNavigationBarView = {
        let navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavoriteCardCell.self, forCellWithReuseIdentifier: "FavoriteCardCell")
        return collectionView
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.slash")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No Favorites Yet"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyStateSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Star your favorite lessons to find them here"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        
        addSubview(navBar)
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(emptyStateView)
        
        emptyStateView.addSubview(emptyStateImageView)
        emptyStateView.addSubview(emptyStateLabel)
        emptyStateView.addSubview(emptyStateSubtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: self.topAnchor ,constant: 70),
            navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Collection View
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            // Empty State View
            emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            // Empty State Image
            emptyStateImageView.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            emptyStateImageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 80),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Empty State Label
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateImageView.bottomAnchor, constant: 20),
            emptyStateLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            
            // Empty State Subtitle
            emptyStateSubtitleLabel.topAnchor.constraint(equalTo: emptyStateLabel.bottomAnchor, constant: 8),
            emptyStateSubtitleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyStateSubtitleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            emptyStateSubtitleLabel.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    func showEmptyState(_ show: Bool) {
        emptyStateView.isHidden = !show
        collectionView.isHidden = show
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
}

// MARK: - Favorite Card Cell
class FavoriteCardCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressBarFill: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressBarFillWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(starIcon)
        containerView.addSubview(titleLabel)
        containerView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBarFill)
        containerView.addSubview(progressLabel)
        
        progressBarFillWidthConstraint = progressBarFill.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            starIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            starIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            starIcon.widthAnchor.constraint(equalToConstant: 28),
            starIcon.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: starIcon.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            progressBarBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            progressBarBackground.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            progressBarBackground.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 8),
            
            progressBarFill.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBarFill.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarFillWidthConstraint!,
            
            progressLabel.topAnchor.constraint(equalTo: progressBarBackground.bottomAnchor, constant: 8),
            progressLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            progressLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with lesson: FavoriteLesson) {
        titleLabel.text = lesson.title
        progressLabel.text = "\(lesson.progressPercentage)% Complete"
        
        // Animate progress bar fill
        let targetWidth = progressBarBackground.bounds.width * (CGFloat(lesson.progressPercentage) / 100.0)
        progressBarFillWidthConstraint?.constant = targetWidth
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.layoutIfNeeded()
        }
        
        // Change progress bar color based on completion
        if lesson.progressPercentage == 100 {
            progressBarFill.backgroundColor = .systemGreen
        } else if lesson.progressPercentage >= 50 {
            progressBarFill.backgroundColor = .systemBlue
        } else {
            progressBarFill.backgroundColor = .systemOrange
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update progress bar width when layout changes
        if let lesson = currentLesson {
            let targetWidth = progressBarBackground.bounds.width * (CGFloat(lesson.progressPercentage) / 100.0)
            progressBarFillWidthConstraint?.constant = targetWidth
        }
    }
    
    private var currentLesson: FavoriteLesson?
    
    func configure(with lesson: FavoriteLesson, animated: Bool = true) {
        currentLesson = lesson
        titleLabel.text = lesson.title
        progressLabel.text = "\(lesson.progressPercentage)% Complete"
        
        // Update progress bar
        let targetWidth = progressBarBackground.bounds.width * (CGFloat(lesson.progressPercentage) / 100.0)
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.progressBarFillWidthConstraint?.constant = targetWidth
                self.layoutIfNeeded()
            }
        } else {
            progressBarFillWidthConstraint?.constant = targetWidth
        }
        
        // Change progress bar color based on completion
        if lesson.progressPercentage == 100 {
            progressBarFill.backgroundColor = .systemGreen
        } else if lesson.progressPercentage >= 50 {
            progressBarFill.backgroundColor = .systemBlue
        } else {
            progressBarFill.backgroundColor = .systemOrange
        }
    }
}

// MARK: - Model
struct FavoriteLesson {
    let id: String
    let title: String
    let progressPercentage: Int // 0-100
}
