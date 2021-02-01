//
//  SearchItemTableViewCell.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 1/20/21.
//

import UIKit
protocol SearchItemCellDelegate {
    func buttonTapped(sender: SearchItemTableViewCell)
}

class SearchItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButtonItem: UIButton!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var item: Product!
    var delegate: SearchItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoLabel.alpha = 0
        infoLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        print("Я в кастомной ячейке")
    }

    func configure(for item: Product ,with editStatus: Bool, delegate: SearchItemCellDelegate, searchText: String) {
        self.checkButtonItem.layer.cornerRadius = 14
        self.nameItem.text = item.title
        self.item = item
        
        if editStatus {
            DatabaseService.shared.getItemRef(uid: item.uid).child(searchText).setValue(item.convertedDictionary())
            self.nameItem.text = searchText.lowercased()
            print("yapp 1")
        }

            if item.completed {
                self.checkButtonItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.checkButtonItem.setBackgroundImage(UIImage(systemName: "face.smiling"), for: .normal)
                self.checkButtonItem.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//                showIshiddenText(text: "Добавлено")
            } else {
                self.checkButtonItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                self.checkButtonItem.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
                self.checkButtonItem.backgroundColor = .clear
            }
        
        self.delegate = delegate
    }
    
//    func showIshiddenText(text: String) {
//        infoLabel.text = text
//        UIView.animate(withDuration: 1,
//            delay: 0,
//            usingSpringWithDamping: 1,
//            initialSpringVelocity: 1,
//            options: .curveLinear,
//            animations: { [weak self] in
//                self?.infoLabel.alpha = 1
//            })
//            {[weak self] complete in
//                self?.infoLabel.alpha = 0
//            }
//    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(sender: self)
    }

}
