//
//  FavoriteCardCell.swift
//  Group6_RyuKoi
//
//  Created by Allison Lee on 11/26/25.
//

import UIKit

class FavoriteCardCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var lesson: FavoriteLesson? {
        didSet { configure(with: lesson) }
    }
    
    static let identifier = "FavoriteCardCell"
    
    // MARK: - UI Elements
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.25)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressBarFill: UIView = {
        let view = UIView()
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
    private var currentLesson: FavoriteLesson?
    
    // MARK: - Selection Highlight
    
    override var isSelected: Bool {
        didSet {
            cardView.backgroundColor = isSelected
                ? UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.55)
                : UIColor(red: 0.933, green: 0.81, blue: 0.55, alpha: 1.0)
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let lesson = currentLesson {
            let newWidth = progressBarBackground.bounds.width * CGFloat(lesson.progressPercentage) / 100
            progressBarFillWidthConstraint?.constant = newWidth
        }
    }
    
    
    // MARK: - Setup
    
    private func setupViewHierarchy() {
        contentView.addSubview(cardView)
        contentView.addSubview(starIcon)
        
        cardView.addSubview(titleLabel)
        cardView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBarFill)
        cardView.addSubview(progressLabel)
    }
    
    private func setupConstraints() {
        
        progressBarFillWidthConstraint = progressBarFill.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            starIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            starIcon.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            starIcon.widthAnchor.constraint(equalToConstant: 28),
            starIcon.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: starIcon.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            progressBarBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            progressBarBackground.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            progressBarBackground.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 8),
            
            progressBarFill.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBarFill.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarFillWidthConstraint!,
            
            progressLabel.topAnchor.constraint(equalTo: progressBarBackground.bottomAnchor, constant: 8),
            progressLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            progressLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12)
        ])
    }
    
    
    // MARK: - Config
    
    func configure(with lesson: FavoriteLesson?) {
        guard let lesson = lesson else { return }
        
        currentLesson = lesson
        
        titleLabel.text = lesson.title
        progressLabel.text = "\(lesson.progressPercentage)% Complete"
        
        // Star always filled for favorites
        starIcon.image = UIImage(systemName: "star.fill")
        
        updateProgressBar(percentage: lesson.progressPercentage, animated: true)
    }
    
    
    // MARK: - Progress Bar
    
    private func updateProgressBar(percentage: Int, animated: Bool) {
        let fraction = CGFloat(percentage) / 100
        let newWidth = progressBarBackground.bounds.width * fraction
        
        progressBarFill.backgroundColor = {
            switch percentage {
            case 100: return .systemGreen
            case 50...99: return .systemBlue
            default: return .systemOrange
            }
        }()
        
        progressBarFillWidthConstraint?.constant = newWidth
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
