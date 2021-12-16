//
//  HomeCoordinator.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import UIKit
import Combine

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private let container: AppContainer
    private var cancellables = Set<AnyCancellable>()

    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        homeRoot()
    }

    private func homeRoot() {
        let module = HomeModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [unowned self] transition in
                switch transition {
                case .screen1: debugPrint("perform transition 1")
                case .screen2: debugPrint("perform transition 2")
                case .screen3: debugPrint("perform transition 3")
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }
}
