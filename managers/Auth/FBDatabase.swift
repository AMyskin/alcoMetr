//
//  FBDatabase.swift
//  alcoMetr
//
//  Created by Alexander Myskin on 04.07.2021.
//

import FirebaseDatabase

final class FBDatabase {
    
    static let shared = FBDatabase()
    private init () {}
    
    var ref = Database.database(url: "https://alcometr-e0c70-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    func createUser(user: User) {
        let value: [AnyHashable : Any] = [
            "id": user.id,
            "name": user.name,
            "email": user.email,
            "alcoDay": user.alcoDay,
            "date": user.date,
            "dayDrink": user.isDrinkDay,
            "dayCountDrink": user.dayCountDrink,
            "userTimeZone": user.userTimeZone
        ]
        ref.child("users").child(user.id).updateChildValues(value)
    }
    
    func addDrinkDay(user: User) {
        let value: [AnyHashable : Any] = [
            "\(user.date)": Int.random(in: 0..<100)
        ]
        ref.child("drinkDays").child(user.id).setValue(value)
    }
    
    func getDrinkDays(userId: String, completion: @escaping (Result<[DrinkDay], Error>) -> Void) {
        ref.child("drinkDays").child("\(userId)").observe(.value) { (snapshot) in
            guard let dic = snapshot.value as? NSDictionary else {return}
            var days:[DrinkDay] = []
            for key in dic.allKeys {
                let day = Date.makeDateFromString(key as? String ?? "") ?? Date()
                let drinkDay = DrinkDay(date: day, count: dic[key] as! Int)
                days.append(drinkDay)
            }
            completion(.success(days))
        }
    }
    
    func getUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        ref.child("users/\(userId)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                completion(.failure(error))
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                let value = snapshot.value as? NSDictionary
                let user = User(
                    id: value?["id"] as? String ?? "",
                    name: value?["name"] as? String ?? "",
                    email: value?["email"] as? String ?? "",
                    password: value?["password"] as? String ?? "",
                    date: value?["date"] as? String ?? "",
                    dayCountDrink: value?["dayCountDrink"] as? Int ?? 0,
                    alcoDay: value?["alcoDay"] as? Int ?? 0,
                    userTimeZone: value?["userTimeZone"] as? String ?? ""
                )
                completion(.success(user))
            }
            else {
                print("No data available")
                completion(.failure(FirebaseError.noData))
            }
        }
    }
}

enum FirebaseError:Error {
    case noData
}
