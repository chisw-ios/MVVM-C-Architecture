//
//  AuthSelectViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.11.2021.
//

import UIKit

final class AuthSelectViewController: BaseViewController<AuthSelectViewModel> {
    // MARK: - Views
    private let contentView = AuthSelectView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    private func bind() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .signIn: viewModel.showSignIn()
                case .signUp: viewModel.showSignUp()
                case .skip: viewModel.skipAuth()
                }
            }
            .store(in: &cancellables)
    }
}
