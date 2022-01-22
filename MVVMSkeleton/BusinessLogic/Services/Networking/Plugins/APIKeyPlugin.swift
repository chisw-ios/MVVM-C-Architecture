//
//  APIKeyPlugin.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation
import CombineNetworking

struct APIKeyPlugin: CNPlugin {
    let key: String
    
    init(key: String) {
        self.key = key
    }
    
    func modifyRequest(_ request: inout URLRequest) {
        guard let url = request.url,
              var components = URLComponents(string: url.absoluteString) else { return }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(
            URLQueryItem(name: "key", value: key)
        )
        
        components.queryItems = queryItems
        
        guard let newURL = components.url else { return }
        request.url = newURL
    }
}
