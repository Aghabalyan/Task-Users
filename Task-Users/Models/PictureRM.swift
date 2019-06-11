//
//  PictureRM.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import RealmSwift

class PictureRM: Object {
    
    @objc dynamic var large: String?
    @objc dynamic var medium: String?
    @objc dynamic var thumbnail: String?
    
    static func from(model: Picture?) -> PictureRM {
        let rm = PictureRM()
        rm.large = model?.large
        rm.medium = model?.medium
        rm.thumbnail = model?.thumbnail
        return rm
    }
}
