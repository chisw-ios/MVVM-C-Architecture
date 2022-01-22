//
//  TokenService.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Combine
import CombineNetworking

protocol TokenService {
    func refreshToken(_ refreshToken: String) -> AnyPublisher<UserAuthModel, CNError>
}
