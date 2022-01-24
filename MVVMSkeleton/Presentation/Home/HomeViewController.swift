//
//  HomeViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    // MARK: - Views
    private let contentView = HomeView()

    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        title = Localization.home.uppercased()
    }

    private func setupBindings() {
        viewModel.$characters
            .sink { [unowned self] characters in
                contentView.show(characters: characters)
            }
            .store(in: &cancellables)
    }
}
