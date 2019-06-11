//
//  NameRM.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import RealmSwift

class NameRM: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var first: String?
    @objc dynamic var last: String?
    
    static func from(model: Name?) -> NameRM {
        let rm = NameRM()
        rm.title = model?.title
        rm.first = model?.first
        rm.last = model?.last
        return rm
    }
}
