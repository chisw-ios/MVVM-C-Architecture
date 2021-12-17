//
//  DogServiceImpl.swift
//  MVVMSkeleton
//
//  Created by user on 14.12.2021.
//

import Foundation
import Combine
import CombineNetworking

class DogServiceImpl {
    private let provider: CNProvider<DogAPIRequestBuilder, CNErrorHandlerImpl>
    
    init(_ provider: CNProvider<DogAPIRequestBuilder, CNErrorHandlerImpl>) {
        self.provider = provider
    }
}

// MARK: - DogService
extension DogServiceImpl: DogService {
    func getBreeds(_ name: String) -> AnyPublisher<[DogResponseModel], CNError> {
        provider.perform(.search(breeds: name))
            .eraseToAnyPublisher()
    }
}
