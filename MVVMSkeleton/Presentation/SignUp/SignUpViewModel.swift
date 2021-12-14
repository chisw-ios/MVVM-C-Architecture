//
//  SignUpViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import Combine

final class SignUpViewModel: BaseViewModel {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isInputValid: Bool = false

    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SignUpTransition, Never>()

    override func onViewDidLoad() {
        $name.combineLatest($email, $password, $confirmPassword)
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
            .sink { [unowned self] in isInputValid = $0 }
            .store(in: &cancellables)
    }

    func signUpUser() {
        transitionSubject.send(.success)
    }
}
