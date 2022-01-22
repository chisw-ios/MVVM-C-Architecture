//
//  AuthService.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Combine
import CombineNetworking

protocol AuthService {
    func login(_ model: UserAuthRequestModel) -> AnyPublisher<UserAuthModel, CNError>
    func registration(_ model: UserAuthRequestModel) -> AnyPublisher<UserAuthModel, CNError>
}
