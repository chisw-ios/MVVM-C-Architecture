//
//  SignUpViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import Foundation
import Combine

final class SignUpViewModel: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isInputValid: Bool = false

    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SignUpTransition, Never>()
    
    private let authService: AuthService
    private let userService: UserService
    
    init(authService: AuthService,
         userService: UserService) {
        self.authService = authService
        self.userService = userService
        
        super.init()
    }

    override func onViewDidLoad() {
        $email.combineLatest($password, $confirmPassword)
            .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
            .sink { [unowned self] in isInputValid = $0 }
            .store(in: &cancellables)
    }

    func signUpUser() {
        let model = UserAuthRequestModel(email: email, password: password)
        isLoadingSubject.send(true)
        
        authService.registration(model)
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
