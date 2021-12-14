//
//  AuthSelectViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.11.2021.
//

import Combine

final class AuthSelectViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<AuthSelectTransition, Never>()

    func showSignIn() {
        transitionSubject.send(.signIn)
    }
    
    func showSignUp() {
        transitionSubject.send(.signUp)
    }

    func skipAuth() {
        transitionSubject.send(.skip)
    }
}
