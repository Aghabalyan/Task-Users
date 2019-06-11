//
//  Picture.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Picture: Mappable {
    
    var large: String?
    var medium: String?
    var thumbnail: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        large <- map["large"]
        medium <- map["medium"]
        thumbnail <- map["thumbnail"]
    }
    
    init(model: PictureRM?) {
        self.large = model?.large
        self.medium = model?.medium
        self.thumbnail = model?.thumbnail
    }
}
