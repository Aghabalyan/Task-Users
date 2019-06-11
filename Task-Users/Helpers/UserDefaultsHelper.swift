//
//  UserDefaultsHelper.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit

enum UDAliases: String {
    case AuthToken = "auth_token"
    case logined
    
    case userName
    case userImageURL
    case userEmail
    case downloaded
    case DeviceToken
    
    case accessToken
    case refreshToken
}

class UserDefaultsHelper {
    
    static func isNil(_ alias: UDAliases) -> Bool {
        return UserDefaults.standard.string(forKey: alias.rawValue) == nil
    }
    
    static func getString(for alias: UDAliases) -> String? {
        return UserDefaults.standard.string(forKey: alias.rawValue)
    }
    
    static func get(alias: UDAliases) -> Any? {
        return UserDefaults.standard.string(forKey: alias.rawValue)
    }
    
    static func boolFor(alias: UDAliases) -> Bool? {
        return UserDefaults.standard.bool(forKey: alias.rawValue)
    }
    
    static func set(alias: UDAliases, value: String) {
        UserDefaults.standard.set(value, forKey: alias.rawValue)
    }
    
    static func set(alias: UDAliases, value: Any?) {
        UserDefaults.standard.set(value, forKey: alias.rawValue)
    }
    
    static func remove(alias: UDAliases) {
        UserDefaults.standard.removeObject(forKey: alias.rawValue)
    }
    
    static func remove(aliases: UDAliases...) {
        aliases.forEach { (alias) in
            UserDefaults.standard.removeObject(forKey: alias.rawValue)
        }
    }
}
