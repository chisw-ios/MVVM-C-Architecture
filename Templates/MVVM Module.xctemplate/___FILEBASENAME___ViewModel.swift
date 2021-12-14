//___FILEHEADER___

import Combine

final class ___VARIABLE_productName:identifier___ViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<___VARIABLE_productName:identifier___Transition, Never>()
    
    init() {

        super.init()
    }
    
}
