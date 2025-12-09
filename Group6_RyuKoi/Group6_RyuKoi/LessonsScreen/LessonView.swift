import UIKit

class LessonView: UIView {
    var backBtn: UIButton!
    var navBar: TopNavigationBarView!
    var progressBarBackground: UIView!
    var progressBarFill: UIView!
    var lessonName: UILabel!
    var descriptionContainer: UIView!
    var descriptionLabel: UILabel!
    var startBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupBackBtn()
        setupNavBar()
        setupProgressBar()
        setupLessonName()
        setupDescriptionContainer()
        setupDescriptionLabel()
        setupStartBtn()
        initConstraints()
    }
    
    func setupBackBtn() {
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .label
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backBtn)
    }
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupProgressBar() {
        // Background bar
        progressBarBackground = UIView()
        progressBarBackground.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        progressBarBackground.layer.cornerRadius = 5
        progressBarBackground.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBarBackground)
        
        // Fill bar (progress indicator)
        progressBarFill = UIView()
        progressBarFill.backgroundColor = UIColor(red: 220/255, green: 71/255, blue: 49/255, alpha: 1.0)
        progressBarFill.layer.cornerRadius = 5
        progressBarFill.translatesAutoresizingMaskIntoConstraints = false
        progressBarBackground.addSubview(progressBarFill)
    }
    
    func setupLessonName() {
        lessonName = UILabel()
        lessonName.text = "Lesson Name"
        lessonName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lessonName.textAlignment = .center
        lessonName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lessonName)
    }
    
    func setupDescriptionContainer() {
        descriptionContainer = UIView()
        descriptionContainer.backgroundColor = UIColor(red: 1.0, green: 0.973, blue: 0.910, alpha: 1.0)
        descriptionContainer.layer.cornerRadius = 10
        descriptionContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionContainer)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description of what the lesson offers"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer.addSubview(descriptionLabel)
    }
    
    func setupStartBtn() {
        startBtn = UIButton()
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.backgroundColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        startBtn.layer.cornerRadius = 5
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startBtn)
    }
    

    func initConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            backBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            //navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor ,constant: 20),
            navBar.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            progressBarBackground.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            progressBarBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressBarBackground.widthAnchor.constraint(equalToConstant: 300),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 10),

            
            progressBarFill.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBarFill.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarFill.widthAnchor.constraint(equalToConstant: 0),
            
            lessonName.topAnchor.constraint(equalTo: progressBarBackground.bottomAnchor, constant: 20),
            lessonName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descriptionContainer.topAnchor.constraint(equalTo: lessonName.bottomAnchor, constant: 20),
            descriptionContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionContainer.widthAnchor.constraint(equalToConstant: 350),
            descriptionContainer.heightAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 16),
            descriptionLabel.centerXAnchor.constraint(equalTo: descriptionContainer.centerXAnchor),
            
            startBtn.topAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: 20),
            startBtn.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            startBtn.widthAnchor.constraint(equalToConstant: 150),
            startBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
