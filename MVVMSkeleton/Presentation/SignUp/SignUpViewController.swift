//
//  SignUpViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit

final class SignUpViewController: BaseViewController<SignUpViewModel> {
    // MARK: - Views
    private let contentView = SignUpView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        setupBindings()
        super.viewDidLoad()
        title = Localization.signUp.uppercased()
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .nameChanged(let text):
                    viewModel.name = text

                case .emailChanged(let text):
                    viewModel.email = text

                case .passwordChanged(let text):
                    viewModel.password = text

                case .confirmPasswordChanged(let text):
                    viewModel.confirmPassword = text

                case .doneTapped:
                    viewModel.signUpUser()
                }
            }
            .store(in: &cancellables)

        viewModel.$isInputValid
            .sink { [unowned self] isValid in
                contentView.setDoneButton(enabled: isValid)
            }
            .store(in: &cancellables)
    }
}
