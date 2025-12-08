//
//  LoginFirebaseManager.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/4/25.
//

import Foundation
import FirebaseAuth
import UIKit

extension LoginViewController{
    func login(){
        //MARK: Sign In Action
        if let email = loginScreen.email.text,
           let password = loginScreen.password.text{
            isValid(email: email, password: password)
            self.signInToFirebase(email: email, password: password)
        }
    }
    
    func isValid(email: String, password: String){
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        
        if email.isEmpty || password.isEmpty{
            emptyAlert()
            return
        }
        
        if !emailPred.evaluate(with: email) {
            notValidEmailAlert()
            return
        }
    }
    
    func notValidEmailAlert(){
        let alertController = UIAlertController(title: "Error", message: "Please enter a valid email!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func emptyAlert(){
        let alertController = UIAlertController(title: "Error", message: "Feilds cannot be empty!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func errorAlert(){
        let alert = UIAlertController(
            title: "Error!", message: "No user exist! Try again or register yourself",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func signInToFirebase(email: String, password: String){
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                let bottomNav = BottomNavigationViewController()
                self.navigationController?.pushViewController(bottomNav, animated: true)
            }else{
                self.errorAlert()
            }
        })
    }
}

