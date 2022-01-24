//
//  HomeView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.12.2021.
//

import UIKit
import Combine

final class HomeView: BaseView {
    // MARK: - Subviews
    private let tableView = UITableView()
    private var characters: [CharacterModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(characters: [CharacterModel]) {
        self.characters = characters
        self.tableView.reloadData()
    }

    private func initialSetup() {
        setupLayout()
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(CharacterTVC.self, forCellReuseIdentifier: Constant.cellReuseIdentifier)
    }

    private func setupLayout() {
        addSubview(tableView, withEdgeInsets: .zero, safeArea: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReuseIdentifier, for: indexPath) as! CharacterTVC
        let model = characters[indexPath.row]
        cell.setup(model)
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
        ViewRepresentable(HomeView()) {
            $0.show(
                characters: [
                    CharacterModel(
                        gender: "Male",
                        name: "Rick Sanchez",
                        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                        species: "Human",
                        status: "Alive"
                    ),
                    CharacterModel(
                        gender: "Male",
                        name: "Rick Sanchez 2",
                        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                        species: "Human 2",
                        status: "Alive 2"
                    ),
                ]
            )
        }
    }
}
