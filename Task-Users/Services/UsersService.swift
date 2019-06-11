//
//  UsersService.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class UsersService {
    
    static let shered = UsersService()
    func citiesResponse(data: UserForm, completion: @escaping ((UserResponseData<UserResponse>) -> Void)) {
        BaseService.shared.get(endpoint: "/", parameters: data.toJSON(), for: .secure)
            .responseString { (response) in
                print(response.result.value ?? "result value is nil")
                if let responseHttp = response.response, let value = response.result.value {
                    if let baseResponse = BaseService.shared.checkBaseResponse(responseHttp, value) {
                        return completion(.base(response: baseResponse))
                    }
                } else {
                    return completion(.isOffline)
                }
                switch response.response?.statusCode ?? 400 {
                case 200:
                    if let value = response.result.value, let data = Mapper<UserResponse>().map(JSONString: value) {
                        return completion(.success(results: data))
                    }
                    return completion(.base(response: .unexpectedError(error: ResponseUnexpectedError.mappingFailed)))
                default:
                    return completion(.base(response: .badRequest))
                }
        }
    }
}
