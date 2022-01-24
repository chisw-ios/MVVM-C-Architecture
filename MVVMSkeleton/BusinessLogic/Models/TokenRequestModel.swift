//
//  TokenRequestModel.swift
//  MVVMSkeleton
//
//  Created by user on 24.01.2022.
//

import Foundation

struct TokenRequestModel: Encodable {
    let refreshToken: String
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode("refresh_token", forKey: .grantType)
    }
}
