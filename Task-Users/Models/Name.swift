//
//  Name.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Name: Mappable {
    
    var title: String?
    var first: String?
    var last: String?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        title <- map["title"]
        first <- map["first"]
        last <- map["last"]
    }
    
    init(model: NameRM?) {
        self.title = model?.title
        self.first = model?.first
        self.last = model?.last
    }
}
