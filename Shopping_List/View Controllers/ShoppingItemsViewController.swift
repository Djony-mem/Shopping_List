//
//  ListViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class ShoppingItemsViewController: UITableViewController {
    
    var user: AppUser!
    var shopList: List!
    var listRef: DatabaseReference?
    var itemsRef: DatabaseReference?
    var products: [Product] = []
    var items: [Product] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = shopList.title
        listRef = DatabaseService.shared.getListRef(uid: user.uid, list: shopList)
        itemsRef = DatabaseService.shared.getItemRef(uid: user.uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        listRef?.observe(.value) {[weak self] snapshot in
            self?.products = Product.getShopingItem(snapshot: snapshot) ?? []
            self?.tableView.reloadData()
        }
        itemsRef?.observe(.value) { [weak self] snapshot in
                self?.items = Product.getShopingItem(snapshot: snapshot) ?? []
            }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ShoppingItemsTableViewCell
        let product = products[indexPath.row]
        cell.configure(product: product)
        cell.backgroundColor = .clear
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let searchItemVC = navController.viewControllers.first as! SearchItemViewController
        searchItemVC.user = user
        searchItemVC.shopList = shopList
        
    }

    @IBAction func addItemTappedButton(_ sender: Any) {
        for item in items {
            itemsRef?.child(item.title.lowercased()).updateChildValues(["completed": false])
        }
        performSegue(withIdentifier: "showItems", sender: nil)
    }
}
