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

    private let dogService: DogService

    @Published var dogs: [DogResponseModel] = []
    @Published var searchText: String = ""
    
    init(dogService: DogService) {
        self.dogService = dogService
        super.init()
    }
    
    override func onViewDidAppear() {
        super.onViewDidAppear()

        $searchText
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .setFailureType(to: CNError.self)
            .flatMap { [unowned self] text -> AnyPublisher<[DogResponseModel], CNError> in
                isLoadingSubject.send(true)
                return dogService.getBreeds(text)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingSubject.send(false)
                guard case let .failure(error) = completion else {
                    return
                }
                self?.errorSubject.send(error)
            } receiveValue: { [weak self] model in
                self?.isLoadingSubject.send(false)
                self?.dogs = model
            }
            .store(in: &cancellables)
    }

    func showDetail(for dog: DogResponseModel) {
        debugPrint("show detail for ", dog)
    }
}
