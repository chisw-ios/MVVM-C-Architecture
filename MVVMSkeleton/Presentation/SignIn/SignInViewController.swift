//
//  SignInViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit

final class SignInViewController: BaseViewController<SignInViewModel> {
    // MARK: - Views
    private let contentView = SignInView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        title = Localization.signIn.uppercased()
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .emailChanged(let text):
                    viewModel.email = text

                case .passwordChanged(let text):
                    viewModel.password = text

                case .doneTapped:
                    viewModel.signInUser()
                }
            }
            .store(in: &cancellables)

        viewModel.$isInputValid
            .sink { [unowned self] in contentView.setDoneButton(enabled: $0) }
            .store(in: &cancellables)
    }
}
