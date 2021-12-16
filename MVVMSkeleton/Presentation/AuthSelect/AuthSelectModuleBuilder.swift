//
//  AuthSelectModuleBuilder.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.11.2021.
//

import UIKit
import Combine

enum AuthSelectTransition: Transition {
    case signIn, signUp, skip
}

final class AuthSelectModuleBuilder {
    class func build() -> Module<AuthSelectTransition, UIViewController> {
        let viewModel = AuthSelectViewModel()
        let viewController = AuthSelectViewController(viewModel: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
}
