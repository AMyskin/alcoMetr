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
    
    func isAuth(completion: @escaping (Bool) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                completion(false)
            }
            completion(true)
        }
    }
    
    func createUser(user: User, completion: @escaping (Result<User, Error>) -> Void) {
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
                completion(.success(user))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
        
    func loadUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = result {
                completion(.success(true))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func logoutAction() {
        let _ = try? Auth.auth().signOut()
    }
}
