//
//  LocationRM.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import RealmSwift

class LocationRM: Object {
    
    @objc dynamic var street: String?
    @objc dynamic var city: String?
    @objc dynamic var state: String?
    @objc dynamic var postcode: String?
    @objc dynamic var coordinate: CoordinateRM?
    
    static func from(model: Location?) -> LocationRM {
        let rm = LocationRM()
        rm.street = model?.street
        rm.city = model?.city
        rm.state = model?.state
        rm.postcode = model?.postcode
        rm.coordinate = CoordinateRM.from(model: model?.coordinate)
        return rm
    }
}

class CoordinateRM: Object {
    
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    
    static func from(model: Coordinate?) -> CoordinateRM {
        let rm = CoordinateRM()
        rm.latitude = model?.latitude
        rm.longitude = model?.longitude
        return rm
    }
}

