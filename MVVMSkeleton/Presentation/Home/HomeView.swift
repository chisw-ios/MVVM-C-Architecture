//
//  HomeView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.12.2021.
//

import UIKit
import Combine

enum HomeViewAction {
}

final class HomeView: BaseView {
    // MARK: - Properties
    private var dataSource: HomeViewDataSource?
    
    // MARK: - Subviews
    private let tableView = UITableView()

    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<HomeViewAction, Never>()
    
    convenience init(dataSource: HomeViewDataSource) {
        self.init(frame: .zero)
        self.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    private func bindActions() {
    }

    private func setupUI() {
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constant.cellReuseIdentifier
        )
    }

    private func setupLayout() {
        addSubview(tableView, withEdgeInsets: .zero, safeArea: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        dataSource?.numberOfRows ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellReuseIdentifier,
            for: indexPath
        )
        
        let data = dataSource?[data: indexPath] ?? String()
        cell.textLabel?.text = data
        
        return cell
    }
}

// MARK: - View constants
private enum Constant {
    static let cellReuseIdentifier: String = "UITableViewCell"
}

import SwiftUI
struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        ViewRepresentable(HomeView())
    }
}
