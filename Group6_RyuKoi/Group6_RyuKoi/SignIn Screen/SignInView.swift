import UIKit

class SignInView: UIView {
    var container: UIView!
    var firstName: UITextField!
    var lastName: UITextField!
    var email: UITextField!
    var password: UITextField!
    var loginBtn: UIButton!
    var signInBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        setupContainer()
        setupFirstName()
        setupLastName()
        setupEmail()
        setupPassword()
        setupLoginButton()
        setupSigninButton()
        initConstraints()
    }
    
    func setupContainer() {
        container = UIView()
        container.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 232/255, alpha: 1.0)
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
    }
    
    func setupFirstName() {
        firstName = UITextField()
        firstName.placeholder = "First Name"
        firstName.borderStyle = .roundedRect
        firstName.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(firstName)
    }
    
    func setupLastName() {
        lastName = UITextField()
        lastName.placeholder = "Last Name"
        lastName.borderStyle = .roundedRect
        lastName.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(lastName)
    }
    
    func setupEmail() {
        email = UITextField()
        email.placeholder = "Email"
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(email)
    }
    
    func setupPassword() {
        password = UITextField()
        password.placeholder = "Password"
        password.borderStyle = .roundedRect
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(password)
    }
    
    func setupLoginButton() {
        loginBtn = UIButton(type: .system)
        loginBtn.setTitle("Have a Account? Login", for: .normal)
        loginBtn.setTitleColor(UIColor(red: 184/255, green: 57/255, blue: 14/255, alpha: 1), for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginBtn)
    }
    
    func setupSigninButton() {
        signInBtn = UIButton(type: .system)
        signInBtn.setTitle("Sign Up", for: .normal)
        signInBtn.setTitleColor(.white, for: .normal)
        signInBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        signInBtn.backgroundColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        signInBtn.layer.cornerRadius = 8
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(signInBtn)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            firstName.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            firstName.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            firstName.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: -5),
            
            lastName.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            lastName.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: 5),
            lastName.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            email.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 16),
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            password.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            password.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            loginBtn.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            loginBtn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            loginBtn.heightAnchor.constraint(equalToConstant: 44),
            
            signInBtn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 32),
            signInBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            signInBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50),
            signInBtn.widthAnchor.constraint(equalToConstant: 120),
            signInBtn.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

