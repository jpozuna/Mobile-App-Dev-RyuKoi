import UIKit

class PracticeView: UIView {
    
    // MARK: - UI Components
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Camera view (no container around it now)
    let lessonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Done button - replaces the next/complete button
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Navigation buttons (kept for compatibility but hidden)
    let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .label
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .label
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true // Hidden - we use doneButton instead
        return button
    }()
    
    // Progress label (kept for compatibility but hidden)
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    let tipsCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.973, blue: 0.910, alpha: 1.0)
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let tipsChevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .label
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
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
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
        // App background color - cream/beige
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        
        addSubview(backButton)
        addSubview(lessonImageView)
        addSubview(doneButton)
        addSubview(tipsCard)
        tipsCard.addSubview(tipsHeaderButton)
        tipsCard.addSubview(tipsLabel)
        tipsCard.addSubview(tipsChevronIcon)
        tipsCard.addSubview(tipsContentView)
        tipsContentView.addSubview(tipsTextView)
        
        // Add hidden elements for compatibility
        addSubview(progressLabel)
        addSubview(nextButton)
        addSubview(previousButton)
        
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
            
            // Camera view - starts right after back button
            lessonImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            lessonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lessonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lessonImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            
            // Done button - right aligned, above tips
            doneButton.topAnchor.constraint(equalTo: lessonImageView.bottomAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Tips card - below done button
            tipsCard.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 16),
            tipsCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tipsCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tipsCard.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            // Tips header button
            tipsHeaderButton.topAnchor.constraint(equalTo: tipsCard.topAnchor),
            tipsHeaderButton.leadingAnchor.constraint(equalTo: tipsCard.leadingAnchor),
            tipsHeaderButton.trailingAnchor.constraint(equalTo: tipsCard.trailingAnchor),
            tipsHeaderButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),
            
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
            tipsContentView.bottomAnchor.constraint(equalTo: tipsCard.bottomAnchor, constant: -12),
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
    }
    
    func toggleTips() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.isExpanded {
                // Expand to show content - more height for more info
                self.tipsContentHeightConstraint.constant = 180
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
