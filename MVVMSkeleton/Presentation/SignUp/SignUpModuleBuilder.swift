//
//  SignUpModuleBuilder.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit
import Combine

enum SignUpTransition: Transition {
    case success
}

final class SignUpModuleBuilder {
    class func build(container: AppContainer) -> Module<SignUpTransition, UIViewController> {
        let viewModel = SignUpViewModel()
        let viewController = SignUpViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
