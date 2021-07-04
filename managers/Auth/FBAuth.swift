//
//  FBAuth.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 04.07.2021.
//
import Firebase

final class FBAuth {
    static let shared = FBAuth()
    private init () {}
    
    func createUser(user: User, completion: @escaping (User) -> Void) {
        Auth.auth().createUser(
            withEmail: user.email,
            password: user.password) { result, error in
            if let result = result {
                let user = User(
                    id: result.user.uid,
                    name: user.name,
                    email: user.email,
                    password: user.password,
                    date: user.date,
                    dayCountDrink: user.dayCountDrink,
                    alcoDay: user.alcoDay,
                    userTimeZone: user.userTimeZone
                )
                FBDatabase.shared.createUser(user: user)
                completion(user)
            } else {
                let user = User(
                    id: "",
                    name: user.name,
                    email: user.email,
                    password: user.password,
                    date: user.date,
                    dayCountDrink: user.dayCountDrink,
                    alcoDay: user.alcoDay,
                    userTimeZone: user.userTimeZone
                )
                completion(user)
            }
        }
    }

}
