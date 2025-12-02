//
//  PracticeView.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 11/17/25.
//

import UIKit

class PracticeView: UIView {
    
    // MARK: - UI Components
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = .lightGray.withAlphaComponent(0.3)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentCard: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lessonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tipsCard: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tipsHeaderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "Tips:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let tipsChevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tipsContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let tipsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var tipsContentHeightConstraint: NSLayoutConstraint!
    private var isExpanded = false
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backButton)
        addSubview(progressLabel)
        addSubview(contentCard)
        contentCard.addSubview(lessonImageView)
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(tipsCard)
        tipsCard.addSubview(tipsHeaderButton)
        tipsCard.addSubview(tipsLabel)
        tipsCard.addSubview(tipsChevronIcon)
        tipsCard.addSubview(tipsContentView)
        tipsContentView.addSubview(tipsTextView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tipsContentHeightConstraint = tipsContentView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            // Back button
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Progress label
            progressLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Content card
            contentCard.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            contentCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentCard.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.1),
            
            // Lesson image
            lessonImageView.centerYAnchor.constraint(equalTo: contentCard.centerYAnchor),
            lessonImageView.centerXAnchor.constraint(equalTo: contentCard.centerXAnchor),
            lessonImageView.widthAnchor.constraint(equalTo: contentCard.widthAnchor, multiplier: 0.85),
            lessonImageView.heightAnchor.constraint(equalTo: lessonImageView.widthAnchor, multiplier: 1.0),
            
            // Previous button
            previousButton.topAnchor.constraint(equalTo: contentCard.bottomAnchor, constant: 16),
            previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            previousButton.widthAnchor.constraint(equalToConstant: 40),
            previousButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Next button
            nextButton.topAnchor.constraint(equalTo: contentCard.bottomAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Tips card
            tipsCard.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 16),
            tipsCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tipsCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tipsCard.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            // Tips header button (invisible overlay)
            tipsHeaderButton.topAnchor.constraint(equalTo: tipsCard.topAnchor),
            tipsHeaderButton.leadingAnchor.constraint(equalTo: tipsCard.leadingAnchor),
            tipsHeaderButton.trailingAnchor.constraint(equalTo: tipsCard.trailingAnchor),
            tipsHeaderButton.heightAnchor.constraint(equalToConstant: 48),
            
            // Tips label
            tipsLabel.centerYAnchor.constraint(equalTo: tipsHeaderButton.centerYAnchor),
            tipsLabel.leadingAnchor.constraint(equalTo: tipsCard.leadingAnchor, constant: 16),
            
            // Tips chevron icon
            tipsChevronIcon.centerYAnchor.constraint(equalTo: tipsHeaderButton.centerYAnchor),
            tipsChevronIcon.trailingAnchor.constraint(equalTo: tipsCard.trailingAnchor, constant: -16),
            tipsChevronIcon.widthAnchor.constraint(equalToConstant: 20),
            tipsChevronIcon.heightAnchor.constraint(equalToConstant: 20),
            
            // Tips content view
            tipsContentView.topAnchor.constraint(equalTo: tipsHeaderButton.bottomAnchor),
            tipsContentView.leadingAnchor.constraint(equalTo: tipsCard.leadingAnchor, constant: 16),
            tipsContentView.trailingAnchor.constraint(equalTo: tipsCard.trailingAnchor, constant: -16),
            tipsContentView.bottomAnchor.constraint(equalTo: tipsCard.bottomAnchor, constant: -8),
            tipsContentHeightConstraint,
            
            // Tips text view
            tipsTextView.topAnchor.constraint(equalTo: tipsContentView.topAnchor),
            tipsTextView.leadingAnchor.constraint(equalTo: tipsContentView.leadingAnchor),
            tipsTextView.trailingAnchor.constraint(equalTo: tipsContentView.trailingAnchor),
            tipsTextView.bottomAnchor.constraint(equalTo: tipsContentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with lesson: PracticeLesson) {
        lessonImageView.image = UIImage(named: lesson.imageName)
        tipsTextView.text = lesson.tips
        progressLabel.text = "Progress: \(lesson.currentStep)/\(lesson.totalSteps)"
    }
    
    func toggleTips() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.isExpanded {
                // Expand to show content (150 points height for the text view)
                self.tipsContentHeightConstraint.constant = 150
                self.tipsChevronIcon.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                // Collapse to hide content
                self.tipsContentHeightConstraint.constant = 0
                self.tipsChevronIcon.transform = .identity
            }
            self.layoutIfNeeded()
        })
    }
}

// MARK: - Model

struct PracticeLesson {
    let imageName: String
    let tips: String
    let currentStep: Int
    let totalSteps: Int
}
