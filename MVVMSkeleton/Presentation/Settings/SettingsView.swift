//
//  SettingsView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.12.2021.
//

import UIKit
import Combine

enum SettingsViewAction {
    case logoutTapped
}

final class SettingsView: BaseView {
    // MARK: - Subviews
    private let logoutButton = UIButton()

    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<SettingsViewAction, Never>()

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
        logoutButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.logoutTapped) }
            .store(in: &cancellables)
    }

    private func setupUI() {
        backgroundColor = .white
        logoutButton.backgroundColor = .systemRed
        logoutButton.setTitle(Localization.logout, for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.rounded(12)
    }

    private func setupLayout() {
        addSubview(logoutButton, constraints: [
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.buttonInset),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.buttonInset),
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constant.buttonInset),
            logoutButton.heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
        ])
    }
}

// MARK: - View constants
private enum Constant {
    static let buttonInset: CGFloat = 16
    static let buttonHeight: CGFloat = 50
}

import SwiftUI
struct SettingsViewPreview: PreviewProvider {
    static var previews: some View {
        ViewRepresentable(SettingsView())
    }
}
