import UIKit

class LessonView: UIView {
    var backBtn: UIButton!
    var navBar: TopNavigationBarView!
    var lessonName: UILabel!
    var descriptionContainer: UIView!
    var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupBackBtn()
        setupNavBar()
        setupLessonName()
        setupDescriptionContainer()
        setupDescriptionLabel()
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
    

    func initConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            backBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            //navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor ,constant: 20),
            navBar.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            lessonName.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            lessonName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descriptionContainer.topAnchor.constraint(equalTo: lessonName.bottomAnchor, constant: 20),
            descriptionContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionContainer.widthAnchor.constraint(equalToConstant: 350),
            descriptionContainer.heightAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 16),
            descriptionLabel.centerXAnchor.constraint(equalTo: descriptionContainer.centerXAnchor),
            
        ])
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
