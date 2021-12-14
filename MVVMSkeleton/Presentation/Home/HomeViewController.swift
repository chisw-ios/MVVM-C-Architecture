//
//  HomeViewController.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    // MARK: - Views
    private var contentView: HomeView!

    // MARK: - Lifecycle
    override func loadView() {
        contentView = HomeView(dataSource: viewModel)
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        title = Localization.home
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                
                }
            }
            .store(in: &cancellables)
        
        viewModel.reloadDataPublisher
            .sink { [unowned self] _ in
                contentView.reloadData()
            }
            .store(in: &cancellables)
    }
}
