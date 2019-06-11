//
//  User.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import ObjectMapper
import UIKit
import RealmSwift

class UserForm: Mappable {
    
    var results: Int?
    
    init(results: Int) {
        self.results = results
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class UserResponse: Mappable {
    
    var results: [User]?
   
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class User: Mappable {
    
    var userId: String?
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var phone: String?
    var picture: Picture?
    var id: Int?
    
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        userId <- map["id.value"]
        gender <- map["gender"]
        name <- map["name"]
        location <- map["location"]
        email <- map["email"]
        phone <- map["phone"]
        picture <- map["picture"]
    }
    
    init(model: UserRM) {
        self.userId = model.userId
        self.gender = model.gender
        self.name = Name(model: model.name)
        self.location = Location(model: model.location)
        self.email = model.email
        self.phone = model.phone
        self.picture = Picture(model: model.picture)
        self.id = model.id
    }
}

enum UserResponseData<UserResponse> {
    case success(results: UserResponse)
    case base(response: BaseResponse)
    case isOffline
}
