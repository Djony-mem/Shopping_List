//
//  ShoppingItemsTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit

class ShoppingItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var chekButton: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    var product: Product!
    
    func configure(product: Product) {
        self.itemName.text = product.title
        self.quantity.text = String(product.quantity)
        self.chekButton.layer.cornerRadius = 14
        if product.completed {
            self.chekButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.chekButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.itemName.alpha = 0.3
        } else {
            self.chekButton.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.chekButton.backgroundColor = .clear
        }
        
        self.product = product
    }
    @IBAction func addQuantity(_ sender: UIButton) {
        product.quantity += 1
    }
    @IBAction func checkTappedButton(_ sender: UIButton) {
    }
}
