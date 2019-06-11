//
//  Config.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
struct Config {
    static let ENVIRONMENT = "DEV"
    static let HOST_NAME = "randomuser.me"
    static let BASE_URL = "https://" + Config.HOST_NAME + "/api"
    static let API_TOKEN = ""
    static let API_VERSION = "v1"
    static let API_FORMAT = "json"
    static let DEBUG = true
}
