//
//  HomeViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import Combine
import Foundation
import CombineNetworking

final class HomeViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<HomeTransition, Never>()

    private let charactersService: CharactersService
    
    @Published var characters: [CharacterModel] = []

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
        super.init()
    }

    override func onViewDidAppear() {
        super.onViewDidAppear()
        
        charactersService.getCharacters()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingSubject.send(false)
                
                guard case let .failure(error) = completion else {
                    return
                }
                
                self?.errorSubject.send(error)
                
            } receiveValue: { [weak self] response in
                self?.characters = response
            }
            .store(in: &cancellables)
    }
}
