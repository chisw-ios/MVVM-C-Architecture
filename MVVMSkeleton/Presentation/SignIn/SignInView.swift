//
//  SignInView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit
import Combine

enum SignInViewAction {
    case emailChanged(String)
    case passwordChanged(String)
    case doneTapped
}

final class SignInView: BaseView {
    // MARK: - Subviews
    private let scrollView = AxisScrollView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let doneButton = UIButton()

    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<SignInViewAction, Never>()

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

    func setDoneButton(enabled: Bool) {
        doneButton.isEnabled = enabled
        doneButton.alpha = enabled ? 1 : 0.5
    }

    private func bindActions() {
        emailTextField.textPublisher
            .replaceNil(with: "")
            .sink { [unowned self] in actionSubject.send(.emailChanged($0)) }
            .store(in: &cancellables)

        passwordTextField.textPublisher
            .replaceNil(with: "")
            .sink { [unowned self] in actionSubject.send(.passwordChanged($0)) }
            .store(in: &cancellables)

        doneButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.doneTapped) }
            .store(in: &cancellables)
    }

    private func setupUI() {
        backgroundColor = .white
        emailTextField.placeholder = Localization.email
        passwordTextField.placeholder = Localization.password

        [emailTextField, passwordTextField].forEach {
            $0.borderStyle = .roundedRect
        }

        doneButton.setTitle(Localization.signUp, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.rounded(12)
    }

    private func setupLayout() {
        let stack = UIStackView()
        stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: Constant.textFieldSpacing)
        stack.addArranged(emailTextField, size: Constant.textFieldHeight)
        stack.addArranged(passwordTextField, size: Constant.textFieldHeight)
        stack.addSpacer(Constant.textFieldSpacing)
        stack.addArranged(doneButton, size: Constant.doneButtonHeight)

        addSubview(scrollView, withEdgeInsets: .zero, safeArea: true, bottomToKeyboard: true)
        scrollView.contentView.addSubview(stack, withEdgeInsets: .all(Constant.containerSpacing))
    }
}

// MARK: - View constants
private enum Constant {
    static let textFieldHeight: CGFloat = 50
    static let doneButtonHeight: CGFloat = 50
    static let textFieldSpacing: CGFloat = 16
    static let containerSpacing: CGFloat = 16
}

#if DEBUG
import SwiftUI
struct SignInPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(SignInView())
    }
}
#endif
