//
//  User.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 04.07.2021.
//

import Foundation

struct User {
    let id: String
    let name: String
    let email: String
    let password: String
    let date: String
    let isDrinkDay: Bool = false
    let dayCountDrink: Int
    let alcoDay: Int
    
    let userTimeZone: String
}
