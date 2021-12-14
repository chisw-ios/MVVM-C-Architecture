//
//  AuthSelectView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit
import Combine

enum AuthSelectViewAction {
    case signIn
    case signUp
    case skip
}

final class AuthSelectView: BaseView {
    // MARK: - Subviews
    private let buttonsStack = UIStackView()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let skipButton = UIButton()

    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<AuthSelectViewAction, Never>()
    
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
        signInButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.signIn) }
            .store(in: &cancellables)

        signUpButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.signUp) }
            .store(in: &cancellables)

        skipButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.skip) }
            .store(in: &cancellables)
    }

    private func setupUI() {
        backgroundColor = .white
        signInButton.setTitle(Localization.signIn, for: .normal)
        signUpButton.setTitle(Localization.signUp, for: .normal)
        skipButton.setTitle(Localization.skip, for: .normal)

        [signInButton, signUpButton, skipButton].forEach {
            $0.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 15)
            $0.backgroundColor = .systemBlue
            $0.rounded(12)
        }
    }

    private func setupLayout() {
        buttonsStack.setup(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: Constant.buttonSpacing)

        buttonsStack.addArranged(signInButton, size: Constant.buttonHeight)
        buttonsStack.addArranged(signUpButton)
        buttonsStack.addArranged(skipButton)

        addSubview(buttonsStack, constraints: [
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.buttonOffset),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.buttonOffset),
            buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constant.buttonOffset)
        ])
    }
}

// MARK: - View constants
private enum Constant {
    static let buttonOffset: CGFloat = 20
    static let buttonSpacing: CGFloat = 16
    static let buttonHeight: CGFloat = 50
}


import SwiftUI
struct AuthSelectViewPreview: PreviewProvider {
    static var previews: some View {
        ViewRepresentable(AuthSelectView())
    }
}
