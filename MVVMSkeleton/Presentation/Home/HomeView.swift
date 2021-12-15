//
//  HomeView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.12.2021.
//

import UIKit
import Combine

enum HomeViewAction {
    case searchTextChanged(String)
    case didSelect(DogResponseModel)
}

final class HomeView: BaseView {
    // MARK: - Subviews
    private let searchTextField = UITextField()
    private let tableView = UITableView()
    private var dogs: [DogResponseModel] = []

    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<HomeViewAction, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(dogs: [DogResponseModel]) {
        self.dogs = dogs
        self.tableView.reloadData()
    }

    private func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    private func bindActions() {
        searchTextField.textPublisher
            .replaceNil(with: "")
            .removeDuplicates()
            .sink { [unowned self] text in actionSubject.send(.searchTextChanged(text)) }
            .store(in: &cancellables)
    }

    private func setupUI() {
        backgroundColor = .white
        searchTextField.placeholder = Localization.search
        searchTextField.borderStyle = .roundedRect
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellReuseIdentifier)
    }

    private func setupLayout() {
        let stack = UIStackView()
        stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 8)
        stack.addCentered(searchTextField, inset: 16, size: 50)
        stack.addArranged(tableView)
        addSubview(stack, withEdgeInsets: .zero, safeArea: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReuseIdentifier, for: indexPath)
        let data = dogs[indexPath.row].name
        cell.textLabel?.text = data
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dog = dogs[indexPath.row]
        actionSubject.send(.didSelect(dog))
    }
}

// MARK: - View constants
private enum Constant {
    static let cellReuseIdentifier: String = "UITableViewCell"
}

import SwiftUI
struct HomeViewPreview: PreviewProvider {
    static var dogs = [DogResponseModel(name: "Dog 1"),
                       DogResponseModel(name: "Dog 2")]
    static var previews: some View {
        ViewRepresentable(HomeView()) { $0.show(dogs: dogs) }
    }
}
