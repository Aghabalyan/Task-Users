//
//  UserManeger.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import RealmSwift

class UserManager {
    
    static let shared = UserManager()

    func saveUser(user: User, completion: (_ id: Int)->()) {
        let realm = try! Realm()
        let userRM = UserRM()
        userRM.userId = user.userId
        userRM.gender = user.gender
        userRM.name = NameRM.from(model: user.name)
        userRM.location = LocationRM.from(model: user.location)
        userRM.email = user.email
        userRM.phone = user.phone
        userRM.picture = PictureRM.from(model: user.picture)
        userRM.id = incrementID()
        completion(incrementID())
        try! realm.write {
            realm.add(userRM)
        }
    }
    
    func remove(user: UserRM?) {
        guard let user = user else {return}
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(UserRM.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    
}
