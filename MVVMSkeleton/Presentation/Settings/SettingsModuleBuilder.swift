//
//  SettingsModuleBuilder.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import UIKit
import Combine

enum SettingsTransition: Transition {
    case logout
}

final class SettingsModuleBuilder {
    class func build(container: AppContainer) -> Module<SettingsTransition, UIViewController> {
        let viewModel = SettingsViewModel(userService: container.userService)
        let viewController = SettingsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
