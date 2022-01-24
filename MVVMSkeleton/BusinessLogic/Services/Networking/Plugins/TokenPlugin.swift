//
//  TokenPlugin.swift
//  MVVMSkeleton
//
//  Created by user on 14.12.2021.
//

import Foundation
import CombineNetworking

struct TokenPlugin: CNPlugin {
    private let userService: UserService
    
    init(_ userService: UserService) {
        self.userService = userService
    }
    
    func modifyRequest(_ request: inout URLRequest) {
        guard let url = request.url,
              let token = userService.token,
              var components = URLComponents(string: url.absoluteString) else { return }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(
            URLQueryItem(name: "auth", value: token)
        )
        
        components.queryItems = queryItems
        
        guard let newURL = components.url else { return }
        request.url = newURL
    }
}
