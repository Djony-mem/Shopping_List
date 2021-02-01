//
//  Users.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/7/20.
//

import Foundation
import Firebase

struct AppUser {
    let uid: String
    let email: String
    var items: [Product] = []
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
//    
//    static func getItems(snapshot: DataSnapshot) -> [Product]? {
//        var products = [Product]()
//        guard let snapDictionary = snapshot.value as? [String: [String: Any]]
//        else {
//            return nil
//        }
//        for snap in snapDictionary {
//            guard let product = Product(productDict: snap.value)
//            else {
//                continue
//            }
//            products.append(product)
//        }
//       return products
//    }
}
