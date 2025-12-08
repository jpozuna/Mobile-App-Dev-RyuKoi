//
//  SignupFirebaseManager.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/4/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension SignInViewController{
    //MARK: checks to see if inputs are either empty or valid and throws alert
    func isValid(name: String, email: String, password: String, verifyPassword: String){
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        let passwordRegEx = "^.{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        
        if name.isEmpty || email.isEmpty || password.isEmpty || verifyPassword.isEmpty{
            emptyAlert()
            return
        }
        
        if !emailPred.evaluate(with: email) {
            notValidEmailAlert()
            return
        }
        
        if !passwordPred.evaluate(with: password) {
            notValidPasswordAlert()
            return
        }
    }
    
    func notValidEmailAlert(){
        let alertController = UIAlertController(title: "Error", message: "Please enter a valid email!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func notValidPasswordAlert(){
        let alertController = UIAlertController(title: "Error", message: "Password must be at least 6 characters long!", preferredStyle: .alert)
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
    
    
    //MARK: creates new user with email and password
    func registerNewAccount(){
        if let first = signinScreen.firstName.text,
           let last = signinScreen.lastName.text,
           let email = signinScreen.email.text,
           let password = signinScreen.password.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    let fullName = "\(first) \(last)"
                    self.setNameOfTheUserInFirebaseAuth(name: fullName)
                    let newUser = User(name: fullName, email: email, password: password, favoriteLessons: [], notifications: [], lessonProgress: [])
                    self.saveUserToFireStore(user: newUser)
                }else{
                    //MARK: there is a error creating the user...
                    print("error Creating user on signup")
                }
            })
        }
    }
    
    //MARK: Saves user to the FireStore
    func saveUserToFireStore(user: User) {
        let database = Firestore.firestore()
        database.collection("users")
            .document(user.email.lowercased())
            .setData([
                "name": user.name,
                "email": user.email,
                "password": user.password
            ]) { error in
                if error != nil {
                    print("Error adding user to Firestore")
                } else {
                    print("User successfully added to database.")
                }
            }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error occured: \(error)")
                return
            }
            
            let bottomNav = BottomNavigationViewController()
            self.navigationController?.pushViewController(bottomNav, animated: true)
        }
    }
    
}
