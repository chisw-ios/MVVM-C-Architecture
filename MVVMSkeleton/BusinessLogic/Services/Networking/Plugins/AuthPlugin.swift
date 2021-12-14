//
//  AuthPlugin.swift
//  MVVMSkeleton
//
//  Created by user on 14.12.2021.
//

import Foundation
import CombineNetworking

struct AuthPlugin: CNPlugin {
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func modifyRequest(_ request: inout URLRequest) {
        request.setValue(token, forHTTPHeaderField: "x-api-key")
    }
}
