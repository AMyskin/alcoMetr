//
//  LoginViewController.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 06.06.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var isSignup = true{
        willSet {
            if !newValue {
                titleLabel.text = "Вход"
                changeAuthLable.text = "Хотите зарегистрироваться?"
                secondButton.setTitle("Зарегистрироваться", for: .normal)
                name.isHidden = true
                mainButton.setTitle("Войти", for: .normal)
            }
            else {
                titleLabel.text = "Регистрация"
                changeAuthLable.text = "У вас уже есть аккаунт?"
                name.isHidden = false
                secondButton.setTitle("Аторизоваться", for: .normal)
                mainButton.setTitle("Зарегистрироваться", for: .normal)
            }
        }
    }
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var changeAuthLable: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    
    @IBAction func toLoginButton(_ sender: Any) {
        isSignup = !isSignup
    }
    
    @IBAction func LoginButton(_ sender: Any) {

        if isSignup {
            let user = User(
                id: "",
                name: name.text ?? "",
                email: email.text ?? "",
                password: password.text ?? "",
                date: Date().description,
                dayCountDrink: 0,
                alcoDay: 0,
                userTimeZone: TimeZone.current.abbreviation()?.description ?? ""
            )
            if cheakAllFields(isSignup) {
                FBAuth.shared.createUser(user: user) { [weak self] result in
                    switch result {
                    case .success:
                        self?.dismiss(animated: true, completion: nil)
                    case .failure(let error):
                        self?.showAlert(with: error.localizedDescription)
                    }
                }
            }
        } else {
            if cheakAllFields(isSignup) {
                guard let email = email.text,
                      let password = password.text else {return}
                FBAuth.shared.loadUser(email: email, password: password) { [weak self] result in
                    switch result {
                    case .success:
                        self?.dismiss(animated: true, completion: nil)
                    case .failure(let error):
                        self?.showAlert(with: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private var router: AuthRouterRoutingLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func cheakAllFields(_ isSignup: Bool) -> Bool {
        if isSignup {
            guard let name = name.text?.isEmpty,
                  let email = email.text?.isEmpty,
                  let password = password.text?.isEmpty
            else {
                return false
            }
            return !name && !email && !password
        } else {
            guard let email = email.text?.isEmpty,
                  let password = password.text?.isEmpty
            else {
                return false
            }
            return !email && !password
        }
    }
    
    private func showAlert(with text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}
