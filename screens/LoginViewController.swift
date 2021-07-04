//
//  LoginViewController.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 06.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func toLoginButton(_ sender: Any) {
    }
    
    @IBAction func LoginButton(_ sender: Any) {
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
        FBAuth.shared.createUser(user: user) { user in
            print(user.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    



}
