//
//  HomeLessonCell.swift
//  RyūKoi
//
//  Created by Allison Lee on 11/13/25.
//

import UIKit

class HomeLessonCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var lesson: Lesson? {
        didSet { configure(with: lesson) }
    }
    
    static let identifier = "HomeLessonCell"
    
    // MARK: - UI Elements
    
    private let lessonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 208/255, blue: 141/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    /*
    public let starIcon: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()*/
    
    public let starIcon: UIButton = {
        let iv = UIButton()
        iv.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
    private var currentLesson: Lesson?
    
    
    // MARK: - Selection Highlight
    
    override var isSelected: Bool {
        didSet {
            lessonView.backgroundColor = isSelected
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
        contentView.addSubview(lessonView)
        contentView.addSubview(starIcon)
        
        lessonView.addSubview(titleLabel)
        lessonView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBarFill)
        lessonView.addSubview(progressLabel)
    }
    
    
    private func setupConstraints() {
        
        progressBarFillWidthConstraint = progressBarFill.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            
            // Lesson container
            lessonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lessonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lessonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lessonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Star icon
            starIcon.topAnchor.constraint(equalTo: lessonView.topAnchor, constant: 12),
            starIcon.trailingAnchor.constraint(equalTo: lessonView.trailingAnchor, constant: -12),
            starIcon.widthAnchor.constraint(equalToConstant: 28),
            starIcon.heightAnchor.constraint(equalToConstant: 28),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: starIcon.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: lessonView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: lessonView.trailingAnchor, constant: -12),
            
            // Progress background
            progressBarBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            progressBarBackground.leadingAnchor.constraint(equalTo: lessonView.leadingAnchor, constant: 16),
            progressBarBackground.trailingAnchor.constraint(equalTo: lessonView.trailingAnchor, constant: -16),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 8),
            
            // Progress fill
            progressBarFill.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBarFill.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarFillWidthConstraint!,
            
            // Progress label
            progressLabel.topAnchor.constraint(equalTo: progressBarBackground.bottomAnchor, constant: 8),
            progressLabel.centerXAnchor.constraint(equalTo: lessonView.centerXAnchor),
            progressLabel.bottomAnchor.constraint(lessThanOrEqualTo: lessonView.bottomAnchor, constant: -12)
        ])
    }
    
    
    // MARK: - Config
    
    func configure(with lesson: Lesson?) {
        guard let lesson = lesson else { return }
        
        currentLesson = lesson
        
        titleLabel.text = lesson.title
        progressLabel.text = "\(lesson.progressPercentage)% Complete"
        
        // Star icon depends on favorite
        starIcon.setImage(UIImage(systemName: "star"), for: .normal)
        starIcon.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        
        updateProgress(percentage: lesson.progressPercentage, animated: true)
    }
    
    
    // MARK: - Progress Bar
    
    private func updateProgress(percentage: Int, animated: Bool) {
        
        let frac = CGFloat(percentage) / 100
        let targetWidth = progressBarBackground.bounds.width * frac
        
        progressBarFill.backgroundColor = {
            switch percentage {
            case 100: return .systemGreen
            case 50...99: return .systemBlue
            default: return .systemOrange
            }
        }()
        
        progressBarFillWidthConstraint?.constant = targetWidth
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
