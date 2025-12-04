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
                "email": user.email
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
