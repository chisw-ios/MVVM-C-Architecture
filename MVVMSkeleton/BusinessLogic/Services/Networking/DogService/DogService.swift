//
//  DogService.swift
//  MVVMSkeleton
//
//  Created by user on 14.12.2021.
//

import Combine
import CombineNetworking

protocol DogService {
    func getBreeds(_ name: String) -> AnyPublisher<[DogResponseModel], CNError>
}
