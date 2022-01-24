//
//  CharactersServiceImpl.swift
//  MVVMSkeleton
//
//  Created by user on 24.01.2022.
//

import Foundation
import Combine
import CombineNetworking

struct CharactersServiceImpl {
    private let provider: CNProvider<CharactersAPIRequestBuilder, NetworkingHandler>
    
    init(_ provider: CNProvider<CharactersAPIRequestBuilder, NetworkingHandler>) {
        self.provider = provider
    }
}

// MARK: - CharactersService
extension CharactersServiceImpl: CharactersService {
    func getCharacters() -> AnyPublisher<[CharacterModel], CNError> {
        provider.perform(.getCharacters)
            .eraseToAnyPublisher()
    }
}
