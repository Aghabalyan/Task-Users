//
//  CheckBaseHelper.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation
import UIKit

class CheckBaseHelper {
    
    static func checkBaseResponse(_ baseResponse: BaseResponse, viewController: UIViewController) {
        switch baseResponse {
        case .badRequest:
            let alert = AlertControllerHelper.showAlert(title: "Bed request", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .validationProblem(error: let error):
            let alert = AlertControllerHelper.showAlert(title: error.detail, message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .unauthorized:
            let alert = AlertControllerHelper.showAlert(title: "Invalid credentials", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .serviceOffline:
            let alert = AlertControllerHelper.showAlert(title: "Service is Offline", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .notFound:
            let alert = AlertControllerHelper.showAlert(title: "Bad credentials", message: nil)
            viewController.present(alert, animated: true, completion: nil)
        case .unexpectedError(error: let error):
            let alert = AlertControllerHelper.showAlert(title: error.message, message: nil)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
