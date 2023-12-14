//
//  ServiceHelper.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import Alamofire

final class ServiceHelper {
    private init() {}
    static let shared = ServiceHelper()

    func encodeBackendMessageAsError(from data: Data?, statusCode: Int?, responseError: AFError?) -> Error? {
        guard let data = data else { return responseError }
        do {
            let backendMessage = try JSONDecoder().decode(GenericBackendMessage.self, from: data)
            if let message = backendMessage.message {
                return ErrorUtil.createError(from: message, statusCode: statusCode)
            } else {
                return ErrorUtil.createError(from: "It looks like something went wrong.\nPlease try again.", statusCode: statusCode)
            }
        } catch {
            return responseError
        }
    }
}
