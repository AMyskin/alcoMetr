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
    

}
