//
//  AuthRouter.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 04.07.2021.
//

import Foundation

protocol AuthRouterRoutingLogic {
    func routeToMainVC()
}

final class AuthRouter: AuthRouterRoutingLogic {
    
    weak var viewController: LoginViewController?
    
    func routeToMainVC() {
        let vc = MainVC()
    }
}
