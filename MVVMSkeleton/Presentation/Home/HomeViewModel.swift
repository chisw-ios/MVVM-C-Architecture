//
//  HomeViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import Combine
import Foundation

protocol HomeViewDataSource {
    var numberOfRows: Int { get }
    
    subscript (data forRowAt: IndexPath) -> String { get }
}

final class HomeViewModel: BaseViewModel {
    private(set) lazy var reloadDataPublisher = reloadDataSubject.eraseToAnyPublisher()
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let transitionSubject = PassthroughSubject<HomeTransition, Never>()
    private let dogService: DogService
    private var dataSource = [DogResponseModel]()
    
    init(dogService: DogService) {
        self.dogService = dogService
        super.init()
    }
    
    override func onViewDidAppear() {
        super.onViewDidAppear()
        loadData()
    }
    
    private func loadData() {
        isLoadingSubject.send(true)
        
        dogService.getBreeds("cor")
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else {
                    return
                }
                
                self?.isLoadingSubject.send(false)
                self?.errorSubject.send(error)
                
            } receiveValue: { [weak self] model in
                self?.isLoadingSubject.send(false)
                self?.dataSource = model
                self?.reloadDataSubject.send()
            }
            .store(in: &cancellables)
    }
}

// MARK: - HomeViewDataSource
extension HomeViewModel: HomeViewDataSource {
    var numberOfRows: Int {
        dataSource.count
    }
    
    subscript (data forRowAt: IndexPath) -> String {
        dataSource[forRowAt.row].name
    }
}
