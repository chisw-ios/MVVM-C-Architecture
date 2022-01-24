//
//  TokenAPIRequestBuilder.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation
import CombineNetworking

enum TokenAPIRequestBuilder: CNRequestBuilder {
    case refreshToken(model: TokenRequestModel)
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/v1/token"
        }
    }
    
    var query: QueryItems? { nil }
    var body: Data? {
        switch self {
        case .refreshToken(let model):
            return try? JSONEncoder().encode(model)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .refreshToken:
            return .post
        }
    }
}
