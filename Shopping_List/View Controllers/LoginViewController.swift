//
//  LoginViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var enterStackView: UIStackView!
    @IBOutlet weak var registerStackView: UIStackView!
    
    @IBOutlet weak var warningEnter: UILabel!
    @IBOutlet weak var emailTFEnter: UITextField!
    @IBOutlet weak var passwordTFEnter: UITextField!
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        warningEnter.alpha = 0
        warningLabel.alpha = 0
        enterStackView.isHidden = true
        registerStackView.isHidden = false
        
        DatabaseService.shared.addStateDidChangeListener {
            self.performSegue(withIdentifier: "listsSegue", sender: nil)
        }
    }
    
    func displayWarningLabel(with text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.warningLabel.alpha = 1
            })
            {[weak self] complete in
                self?.warningLabel.alpha = 0
            }
    }
    func displayWarningEnter(with text: String) {
        warningEnter.text = text
        
        UIView.animate(withDuration: 3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.warningEnter.alpha = 1
            })
            {[weak self] complete in
                self?.warningEnter.alpha = 0
            }
    }
    
    
    @IBAction func recoveryPassword(_ sender: Any) {
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != ""
        else {
            displayWarningLabel(with: "Не верная информация")
          return
        }
        
        DatabaseService.shared.createUser(email: email, password: password) {[weak self] user in
            let userRef = DatabaseService.shared.allListRef.child(user.uid)
            userRef.setValue(["email": self?.emailTextField.text, "password": self?.passwordTextField.text])
        }
//        self.performSegue(withIdentifier: "listsSegue", sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        guard let email = emailTFEnter.text, let password = passwordTFEnter.text, email != "", password != ""
        else {
            displayWarningEnter(with: "Не верная информация")
          return
        }
        
        DatabaseService.shared.signIn(email: email, password: password) {
            self.displayWarningEnter(with: "Произошла ошибка")
        } complitionTow: {
            self.performSegue(withIdentifier: "listsSegue", sender: nil)
        } complitionThree: {
            self.displayWarningLabel(with: "Нет такого пользователя")
        }
    }
    
    @IBAction func goToEnter(_ sender: UIButton) {
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        registerStackView.isHidden = true
        enterStackView.isHidden = false
    }
    
    @IBAction func goToRegistration(_ sender: Any) {
        view.backgroundColor = #colorLiteral(red: 0.5347137451, green: 0.800742805, blue: 1, alpha: 1)
        registerStackView.isHidden = false
        enterStackView.isHidden = true
    }
}

