//
//  ShopingListViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class AllListsViewController: UITableViewController {
    var shopListRef: DatabaseReference?
    var user: AppUser?
    var shopLists: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = DatabaseService.shared.authCurrentUserRef else { return }
        user = AppUser(user: currentUser)
        guard let user = user else { return }
        shopListRef = DatabaseService.shared.getShoppingListRef(uid: user.uid)
        
        tableView.rowHeight = 80
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shopListRef?.observe(.value) {[weak self] snapshot in
            self?.shopLists = List.getShopingList(snapshot: snapshot) ?? []
            
            self?.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        shopLists.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let shopSection = shopLists[indexPath.section]
        cell.textLabel?.text = shopSection.title
        cell.detailTextLabel?.text = "\(shopSection.product?.count ?? 0)"
        cell.backgroundColor = #colorLiteral(red: 0.9846093059, green: 0.9776827693, blue: 0.9067073464, alpha: 1)
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let shopList = shopLists[indexPath.section]
        let shoppingItemsVC = segue.destination as! ShoppingItemsViewController
        shoppingItemsVC.shopList = shopList
        shoppingItemsVC.user = user
    }

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        DatabaseService.shared.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewList(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Новый список", message: "Добавьте список", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }

            let list = List(title: textField.text!, uid: (self?.user?.uid)!)
            let listRef = self?.shopListRef?.child(list.title.lowercased() )
            listRef?.setValue(list.convertedDictionary())
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
