//
//  ViewController.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 06.06.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBAction func back(_ sender: Any) {
        FBAuth.shared.logoutAction()
        showAuth()
    }
    @IBAction func drinkButton(_ sender: UIButton) {
        print("drink")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FBAuth.shared.isAuth { auth in
            if !auth {
                self.showAuth()
            }
        }
    }
    
    private func showAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }


}

