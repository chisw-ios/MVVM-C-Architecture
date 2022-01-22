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
        guard let token = userService.token else { return }
        
        request.setValue(token, forHTTPHeaderField: "auth")
    }
}
