//
//  FirebaseManager.swift
//  Group6_RyuKoi
//
//  Created by Joshua Paulino Ozuna on 12/10/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Favorites Manager (Firebase)

class FavoritesManager {
    
    static let shared = FavoritesManager()
    private let database = Firestore.firestore()
    
    private init() {}
    
    /// Add a lesson to favorites in Firebase
    func addToFavorites(lessonTitle: String, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("❌ No user logged in")
            completion(false)
            return
        }
        
        database.collection("users")
            .document(userEmail.lowercased())
            .collection("favorites")
            .document(lessonTitle)
            .setData([
                "title": lessonTitle,
                "addedAt": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    print("❌ Error adding to favorites: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("✅ Added to favorites: \(lessonTitle)")
                    completion(true)
                }
            }
    }
    
    /// Remove a lesson from favorites in Firebase
    func removeFromFavorites(lessonTitle: String, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("❌ No user logged in")
            completion(false)
            return
        }
        
        database.collection("users")
            .document(userEmail.lowercased())
            .collection("favorites")
            .document(lessonTitle)
            .delete { error in
                if let error = error {
                    print("❌ Error removing from favorites: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("✅ Removed from favorites: \(lessonTitle)")
                    completion(true)
                }
            }
    }
    
    /// Toggle favorite status (add if not favorited, remove if already favorited)
    func toggleFavorite(lessonTitle: String, completion: @escaping (Bool, Bool) -> Void) {
        checkIfFavorited(lessonTitle: lessonTitle) { [weak self] isFavorited in
            if isFavorited {
                // Remove from favorites
                self?.removeFromFavorites(lessonTitle: lessonTitle) { success in
                    completion(success, false) // false = not favorited anymore
                }
            } else {
                // Add to favorites
                self?.addToFavorites(lessonTitle: lessonTitle) { success in
                    completion(success, true) // true = now favorited
                }
            }
        }
    }
    
    /// Check if a lesson is currently favorited
    func checkIfFavorited(lessonTitle: String, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }
        
        database.collection("users")
            .document(userEmail.lowercased())
            .collection("favorites")
            .document(lessonTitle)
            .getDocument { document, error in
                if let error = error {
                    print("❌ Error checking favorite: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(document?.exists ?? false)
            }
    }
}
