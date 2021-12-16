//
//  SignInModuleBuilder.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit
import Combine

enum SignInTransition: Transition {
    case success
}

final class SignInModuleBuilder {
    class func build(container: AppContainer) -> Module<SignInTransition, UIViewController> {
        let viewModel = SignInViewModel(authService: container.authService,
                                        userService: container.userService)
        let viewController = SignInViewController(viewModel: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
}
