//
//  ErrorUtil.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation

final class ErrorUtil {
    static func createError(from backendMessage: GenericBackendMessage, statusCode: Int?) -> Error {
        return NSError(domain: FWFConstant.errorDomain.rawValue, code: statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: backendMessage.message ?? ""])
    }
    
    static func createError(from string: String, statusCode: Int?) -> Error {
        return NSError(domain: FWFConstant.errorDomain.rawValue, code: statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: string])
    }
}
