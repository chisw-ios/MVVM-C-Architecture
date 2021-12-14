//___FILEHEADER___

import UIKit
import Combine

enum ___VARIABLE_productName:identifier___ViewAction {

}

final class ___VARIABLE_productName:identifier___View: BaseView {
    // MARK: - Subviews


    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<___VARIABLE_productName:identifier___ViewAction, Never>()

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
        backgroundColor = .white
    }

    private func setupLayout() {
    }
}

// MARK: - View constants
private enum Constant {
}

#if DEBUG
import SwiftUI
struct ___VARIABLE_productName:identifier___Preview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(___VARIABLE_productName:identifier___View())
    }
}
#endif
