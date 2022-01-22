//
//  TokenServiceImpl.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Combine
import CombineNetworking

struct TokenServiceImpl {
    private let provider: CNProvider<TokenAPIRequestBuilder, NetworkingHandler>
    
    init(_ provider: CNProvider<TokenAPIRequestBuilder, NetworkingHandler>) {
        self.provider = provider
    }
}

// MARK: - TokenService
extension TokenServiceImpl: TokenService {
    func refreshToken(_ refreshToken: String) -> AnyPublisher<UserAuthModel, CNError> {
        provider.perform(
            .refreshToken(refreshToken: refreshToken),
            decodableType: TokenModel.self
        )
    }
}
