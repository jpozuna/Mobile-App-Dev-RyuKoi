//
//  SignInViewController.swift
//  RyūKoi
//
//  Created by R M on 11/13/25.
//

import UIKit

class SignInViewController: UIViewController {
    let signinScreen = SignInView()
    
    override func loadView() {
        view = signinScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true

        
        signinScreen.signInBtn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signinScreen.loginBtn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleSignIn() {
        let categoriesScreen = CategoriesViewController()
        navigationController?.pushViewController(categoriesScreen, animated: true)
    }
    
    @objc func handleLogin() {
        let loginScreen = LoginViewController()
        navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    
}
