//
//  UserRM.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import RealmSwift

class UserRM: Object {
    
    @objc dynamic var userId: String?
    @objc dynamic var gender: String?
    @objc dynamic var name: NameRM?
    @objc dynamic var location: LocationRM?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var picture: PictureRM?
    
    @objc dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func from(model: User?) -> UserRM {
        let rm = UserRM()
        rm.userId = model?.userId
        rm.gender = model?.gender
        rm.name = NameRM.from(model: model?.name)
        rm.location = LocationRM.from(model: model?.location)
        rm.email = model?.email
        rm.phone = model?.phone
        rm.picture = PictureRM.from(model: model?.picture)
        rm.id = model?.id ?? 0
        return rm
    }
}
