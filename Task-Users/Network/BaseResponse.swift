//
//  BaseResponse.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation

enum BaseResponse {
    /*
     In case there was some problem fetching data from service, this will be returned.
     It really doesn't matter if that is a failure in network layer, parsing error or something else.
     In case data can't be read and parsed properly, something is wrong with server response.
     */
    case serviceOffline
    
    /* http status code 400 */
    case badRequest
    
    /* http status code 401 */
    case unauthorized
    
    /* http status code 404 */
    case notFound
    
    /* http status code 422 */
    case validationProblem(error: ValidationError)
    
    /* http status code 500 */
    case unexpectedError(error: ResponseUnexpectedError)
}
