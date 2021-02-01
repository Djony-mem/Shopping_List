//
//  ShopingList.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/7/20.
//

import Foundation
import Firebase

struct List {
    let title: String
    let uid: String
    var completed: Bool = false
    var product: [Product]?
    
    init(title: String, uid: String, product: [Product] = [], completed: Bool = false) {
        self.title = title
        self.uid = uid
    }
    
    init?(dictionary: [String: Any]) {
        title = dictionary["title"] as! String
        uid = dictionary["uid"] as! String
        completed = dictionary["completed"] as! Bool
        
        let resultDict = dictionary["product"] as? [[String: Any]]
        product = resultDict?.compactMap {Product(productDict: $0)}
 
    }
    
    static func getShopingList(snapshot: DataSnapshot) -> [List]? {
        var lists = [List]()
        guard let snapDictionary = snapshot.value as? [String: [String: Any]]
        else {
            return nil
        }
        for snap in snapDictionary {
            guard let list = List(dictionary: snap.value)
            else {
                continue
            }
            lists.append(list)
        }
       return lists
    }
    
    func convertedDictionary() -> Any {
        return ["title" : title, "uid": uid, "completed": completed]
    }
}
