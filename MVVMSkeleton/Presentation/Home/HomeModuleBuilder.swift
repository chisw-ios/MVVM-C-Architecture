//
//  HomeModuleBuilder.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import UIKit
import Combine

enum HomeTransition: Transition {
    case screen1
    case screen2
    case screen3
}

final class HomeModuleBuilder {
    class func build(container: AppContainer) -> Module<HomeTransition, UIViewController> {
        let viewModel = HomeViewModel(charactersService: container.characterService)
        let viewController = HomeViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
