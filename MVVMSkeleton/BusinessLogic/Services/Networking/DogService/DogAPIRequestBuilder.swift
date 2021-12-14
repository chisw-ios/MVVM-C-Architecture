//
//  DogAPIRequestBuilder.swift
//  MVVMSkeleton
//
//  Created by user on 14.12.2021.
//

import Foundation
import CombineNetworking

enum DogAPIRequestBuilder: CNRequestBuilder {
    case search(breeds: String)
    
    var path: String {
        switch self {
        case .search: return "/breeds/search"
        }
    }
    
    var query: QueryItems? {
        switch self {
        case .search(let breeds):
            return ["q": breeds]
        }
    }
    
    var body: Data? { return nil }
    var method: HTTPMethod { return .get }
}
