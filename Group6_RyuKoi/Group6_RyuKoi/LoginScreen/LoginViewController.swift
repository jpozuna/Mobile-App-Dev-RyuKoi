//
//  LoginViewController.swift
//  RyuKoi
//
//  Created by R M on 11/16/25.
//

import UIKit

class LoginViewController: UIViewController {
    let loginScreen = LoginView()
    let navBar = TopNavigationBarView()
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loginScreen.signInBtn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        loginScreen.loginBtn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleSignIn() {
        let signinScreen = SignInViewController()
       // let communityScreen = CommunityViewController()
        navigationController?.pushViewController(signinScreen, animated: true)
    }
    
    @objc func handleLogin() {
        let bottomNav = BottomNavigationViewController()
        navigationController?.pushViewController(bottomNav, animated: true)
    }
}
