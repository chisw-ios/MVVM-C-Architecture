//
//  SettingsViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import UIKit

final class SettingsViewController: BaseViewController<SettingsViewModel> {
    // MARK: - Views
    private let contentView = SettingsView()

    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        title = Localization.settings.uppercased()
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .logoutTapped:
                    viewModel.logout()
                }
            }
            .store(in: &cancellables)
    }
}
