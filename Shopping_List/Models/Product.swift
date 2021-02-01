//
//  Product.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import Foundation
import Firebase

struct Product {
    let title: String
    var note: String?
    let uid: String
    var completed: Bool = false
    var quantity: Int = 1
    
    init(title: String, uid: String, note: String) {
        self.title = title
        self.uid = uid
        self.note = note
    }
    
    init(productDict: [String: Any]) {
        title = productDict["title"] as! String
        uid = productDict["uid"] as! String
        completed = productDict["completed"] as! Bool
        note = productDict["note"] as? String
        quantity = productDict["quantity"] as! Int
    }
    
    static func getShopingItem(snapshot: DataSnapshot) -> [Product]? {
        var products = [Product]()
        guard let snapDictionary = snapshot.value as? [String: [String: Any]]
        else { return nil }
        
        for snap in snapDictionary {
            let product = Product(productDict: snap.value)
            products.append(product)
        }
       return products
    }
    
    func convertedDictionary() -> Any {
        return ["title" : title, "uid": uid, "completed": completed, "note": note ?? "", quantity: "quantity"]
    }
    
    mutating func checkItem(shopList: List) {
            completed.toggle()
        if completed {
            DatabaseService.shared.getItemRef(uid: uid).child(title.lowercased()).updateChildValues(["completed": true])
            DatabaseService.shared.getItemRef(uid: uid).child(title.lowercased()).setValue(convertedDictionary())
            DatabaseService.shared.getListRef(uid: uid, list: shopList).child(title.lowercased()).setValue(convertedDictionary())
            DatabaseService.shared.getListRef(uid: uid, list: shopList).child(title.lowercased()).updateChildValues(["completed": false])
        } else {
            DatabaseService.shared.getItemRef(uid: uid).child(title.lowercased()).updateChildValues(["completed": false])
            DatabaseService.shared.getListRef(uid: uid, list: shopList).child(title.lowercased()).removeValue()
        }
    }
}
