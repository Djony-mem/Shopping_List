//
//  DatabaseService.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/10/21.
//

import Foundation
import Firebase

class DatabaseService {
    static let shared = DatabaseService()
    private init() {}
    
    let allListRef = Database.database().reference().child("users")
    let authCurrentUserRef = Auth.auth().currentUser
    
    func signOut() {
        do {
            try  Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addStateDidChangeListener(complition: @escaping () -> Void) {
        Auth.auth().addStateDidChangeListener { _ , user in
            if user != nil {
                complition()
            }
        }
    }
    
    func createUser(email: String, password: String, complition: @escaping (User) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            
            guard error == nil, let user = authResult?.user
            else {
                print(error!.localizedDescription)
                return
            }
            complition(user)
        }
    }
    
    func signIn(email: String,
                password: String,
                complitionOne: @escaping () -> Void,
                complitionTow: @escaping () -> Void,
                complitionThree: @escaping () -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                complitionOne()
                return
            }
            if user != nil {
                complitionTow()
                return
            }
            complitionThree()
        }
        
    }
    
    func getShoppingListRef(uid: String) -> DatabaseReference {
      self.allListRef.child(uid).child("shopList")
    }
    
    func getListRef(uid: String, list: List ) -> DatabaseReference {
        self.allListRef.child(uid).child("shopList").child(list.title.lowercased() ).child("products")
    }
    func getItemRef(uid: String) -> DatabaseReference {
        self.allListRef.child(uid).child("items")
    }
}
