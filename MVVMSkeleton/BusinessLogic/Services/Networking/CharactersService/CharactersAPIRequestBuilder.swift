//
//  CharactersAPIRequestBuilder.swift
//  MVVMSkeleton
//
//  Created by user on 24.01.2022.
//

import Foundation
import CombineNetworking

enum CharactersAPIRequestBuilder: CNRequestBuilder {
    case getCharacters
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/results.json"
        }
    }
    
    var query: QueryItems? { nil }
    var body: Data? { nil }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
}
