//
//  SettingsViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Combine

final class SettingsViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SettingsTransition, Never>()
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        super.init()
    }
    
    func logout() {
        userService.clear()
        transitionSubject.send(.logout)
    }
}
