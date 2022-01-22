//
//  SignInViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import Foundation
import Combine

final class SignInViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SignInTransition, Never>()

    private let authService: AuthService
    private let userService: UserService

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false

    @Published private(set) var isInputValid: Bool = false

    init(authService: AuthService,
         userService: UserService) {
        self.authService = authService
        self.userService = userService
        
        super.init()
    }

    override func onViewDidLoad() {
        $email
            .map { $0.count > 5 }
            .sink { [unowned self] in isEmailValid = $0 }
            .store(in: &cancellables)

        $password
            .map { $0.count > 5 }
            .sink { [unowned self] in isPasswordValid = $0 }
            .store(in: &cancellables)

        $isEmailValid.combineLatest($isPasswordValid)
            .map { $0 && $1 }
            .sink { [unowned self] in isInputValid = $0 }
            .store(in: &cancellables)
    }

    func signInUser() {
        let model = UserAuthRequestModel(email: email, password: password)
        isLoadingSubject.send(true)
        
        authService.login(model)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingSubject.send(false)
                
                guard case let .failure(error) = completion else {
                    return
                }
                
                self?.errorSubject.send(error)
                
            } receiveValue: { [weak self] response in
                self?.userService.save(response)
                self?.transitionSubject.send(.success)
            }
            .store(in: &cancellables)
    }
}
