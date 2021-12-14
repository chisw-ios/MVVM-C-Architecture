//___FILEHEADER___

import UIKit
import Combine

enum ___VARIABLE_productName:identifier___Transition: Transition {
    
}

final class ___VARIABLE_productName:identifier___ModuleBuilder {
    class func build(container: AppContainer) -> Module<___VARIABLE_productName:identifier___Transition, UIViewController> {
        let viewModel = ___VARIABLE_productName:identifier___ViewModel()
        let viewController = ___VARIABLE_productName:identifier___ViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
