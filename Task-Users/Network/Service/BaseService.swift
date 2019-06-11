//
//  BaseService.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

struct CustomGetEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

/*
 ServiceState state.
 */
enum ServiceState {
    case online
    case offline
}

enum RequestType {
    case secure
    case unsecure
}

enum AcceptSpecifier: String {
    case `default` = ""
    case special = ".special"
}

class BaseService {
    
    public static let shared = BaseService()
    
    //    func getAcceptHeader(specifier: AcceptSpecifier = .default) -> String {
    //        return "application/vnd.amvigo-elite.\(Config.API_VERSION)\(specifier.rawValue)+\(Config.API_FORMAT);charset=UTF-8"
    //    }
    
    func getHeaders(for: RequestType, specifier: AcceptSpecifier = .default) -> [String: String] {
        switch `for` {
        case .secure:
            guard let token = UserDefaultsHelper.getString(for: .AuthToken) else { return [:] }
            return [
                "Authorization": "Bearer " + token,
                "Accept": "application/json"
            ]
        case .unsecure:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    
    // MARK: - POST requests
    func post(
        endpoint: String,
        array: [String],
        for type: RequestType = .secure
        ) -> DataRequest {
        print(Config.BASE_URL + endpoint)
        return
            request(Config.BASE_URL + endpoint,
                    method: .post, parameters: [:],
                    encoding: JSONStringArrayEncoding(array),
                    headers: getHeaders(for: type))
    }
    
    func post(
        endpoint: String,
        object: [String: Any],
        for type: RequestType = .secure
        ) -> DataRequest {
        print(Config.BASE_URL + endpoint)
        return  request(Config.BASE_URL + endpoint,
                        method: .post, parameters: object,
                        encoding: JSONEncoding.default,
                        headers: getHeaders(for: type))
    }
    
    // MARK: - PATCH requests
    func patch(
        endpoint: String,
        object: [String: Any],
        for type: RequestType = .secure
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .patch,
                       parameters: object,
                       encoding: JSONEncoding.default,
                       headers: getHeaders(for: type))
    }
    
    func patch(
        endpoint: String,
        array: [[String : Any]],
        for type: RequestType = .secure
        ) -> DataRequest {
        print(endpoint)
        return request(Config.BASE_URL + endpoint,
                       method: .patch,
                       parameters: [:],
                       encoding: JSONObjectArrayEncoding(array),
                       headers: getHeaders(for: type))
    }
    
    // MARK: - PUT requests
    func put(
        endpoint: String,
        array: [String],
        for type: RequestType = .secure
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .put,
                       parameters: [:],
                       encoding: JSONStringArrayEncoding(array),
                       headers: getHeaders(for: type))
    }
    
    func put(
        endpoint: String,
        object: [String: Any],
        for type: RequestType = .secure
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .put,
                       parameters: object,
                       encoding: JSONEncoding.default,
                       headers: getHeaders(for: type))
    }
    
    func put(
        endpoint: String,
        objectArray: [[String: Any]],
        for type: RequestType = .secure
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .put,
                       parameters: [:],
                       encoding: JSONObjectArrayEncoding(objectArray),
                       headers: getHeaders(for: type))
    }
    
    // MARK: - DELETE Requests
    func delete(
        endpoint: String,
        object: [String: Any],
        for type: RequestType = .secure
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .delete,
                       parameters: object,
                       encoding: JSONEncoding.default,
                       headers: getHeaders(for: type))
    }
    
    // MARK: - GET Requests
    func get(
        endpoint: String,
        parameters: [String: Any],
        for type: RequestType = .secure,
        specifier: AcceptSpecifier = .default
        ) -> DataRequest {
        print(Config.BASE_URL + endpoint)
        return request(Config.BASE_URL + endpoint,
                       method: .get,
                       parameters: parameters,
                       encoding: CustomGetEncoding(),
                       headers: getHeaders(for: type, specifier: specifier))
    }
    
    // MARK: - Upload Requests
    // TODO
    //    func uploadFormData(
    //        files urls: [String: URL],
    //        to url: String,
    //        for type: RequestType = .secure) -> Observable<(HTTPURLResponse, String)> {
    //        return rxUpload(
    //            multipartFormData: { formData in
    //                _ = urls.map { key, value in
    //                    formData.append(value, withName: key)
    //                }
    //        },
    //            to: Config.BASE_URL + url,
    //            method: .post,
    //            headers: getHeaders(for: type)
    //            )
    //        }
    //    }
    func upload(
        endpoint: String,
        for type: RequestType = .secure,
        specifier: AcceptSpecifier = .default,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?)
    {
        return SessionManager.default.upload(
            multipartFormData: multipartFormData,
            usingThreshold: encodingMemoryThreshold,
            to: (Config.BASE_URL + endpoint as URLConvertible),
            headers: getHeaders(for: type, specifier: specifier),
            encodingCompletion: encodingCompletion
        )
    }
    
    
    
    
    // MARK: - HEAD requests
    func head(
        endpoint: String,
        parameters: [String: Any],
        for type: RequestType = .secure,
        specifier: AcceptSpecifier = .default
        ) -> DataRequest {
        return request(Config.BASE_URL + endpoint,
                       method: .head,
                       parameters: parameters,
                       encoding: CustomGetEncoding(),
                       headers: getHeaders(for: type, specifier: specifier))
    }
    
    // MARK: - Checking base response cases
    func checkBaseResponse(_ httpResponse: HTTPURLResponse, _ string: String) -> BaseResponse? {
        switch httpResponse.statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 404:
            return .notFound
        case 422:
            guard let error = Mapper<ValidationError>().map(JSONString: string) else {
                return .unexpectedError(error: ResponseUnexpectedError.mappingFailed)
            }
            return .validationProblem(error: error)
        case 500..<600:
            guard let error = Mapper<ResponseUnexpectedError>().map(JSONString: string) else {
                return .unexpectedError(error: ResponseUnexpectedError.mappingFailed)
            }
            return .unexpectedError(error: error)
        default:
            return nil
        }
    }
    
    // MARK: - Checking base state cases
    func checkBaseState(response: BaseResponse) -> BaseState {
        switch response {
        case .serviceOffline:
            return BaseState.offline
        case .badRequest:
            return BaseState.badRequestState
        case .unauthorized:
            return BaseState.unauthorizedState
        case .notFound:
            return BaseState.notFoundState
        case let .validationProblem(error: error):
            return BaseState(validationProblem: error)
        case let .unexpectedError(error: error):
            return BaseState(unexpectedError: error)
        }
    }
}

struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String]
    
    init(_ array: [String]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest!
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}

struct JSONObjectArrayEncoding: ParameterEncoding {
    private let array: [[String: Any]]
    
    init(_ array: [[String: Any]]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest!
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}
