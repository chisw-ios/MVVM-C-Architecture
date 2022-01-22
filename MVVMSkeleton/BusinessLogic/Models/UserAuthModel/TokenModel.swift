//
//  TokenModel.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation

struct TokenModel: Decodable, UserAuthModel {
    let idToken: String
    let refreshToken: String
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
        case refreshToken = "refresh_token"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idToken = try container.decode(String.self, forKey: .idToken)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
