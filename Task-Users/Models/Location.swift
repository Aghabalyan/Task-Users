//
//  Location.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
    
    var street: String?
    var city: String?
    var state: String?
    var postcode: String?
    var coordinate: Coordinate?
    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        street <- map["street"]
        city <- map["city"]
        state <- map["state"]
        postcode <- map["postcode"]
        coordinate <- map["coordinate"]
    }
    
    init(model: LocationRM?) {
        self.street = model?.street
        self.city = model?.city
        self.state = model?.state
        self.postcode = model?.postcode
        self.coordinate = Coordinate(model: model?.coordinate)
    }
}

class Coordinate: Mappable {
    
    var latitude: String?
    var longitude: String?

    
    required init?(map: Map) { }
    init() { }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
    init(model: CoordinateRM?) {
        self.latitude = model?.latitude
        self.longitude = model?.longitude
    }
}
