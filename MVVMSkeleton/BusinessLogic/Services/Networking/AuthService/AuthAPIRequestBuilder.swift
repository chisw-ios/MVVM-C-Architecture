//
//  AuthAPIRequestBuilder.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation
import CombineNetworking

enum AuthAPIRequestBuilder: CNRequestBuilder {
    case login(model: UserAuthRequestModel)
    case registration(model: UserAuthRequestModel)
    
    var path: String {
        switch self {
        case .login:
            return "/v1/accounts:signInWithPassword"
        case .registration:
            return "/v1/accounts:signUp"
        }
    }
    
    var query: QueryItems? {
        switch self {
        case .login, .registration:
            return ["returnSecureToken": "true"]
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let model):
            return try? JSONEncoder().encode(model)
            
        case .registration(let model):
            return try? JSONEncoder().encode(model)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .registration:
            return .post
        }
    }
}
