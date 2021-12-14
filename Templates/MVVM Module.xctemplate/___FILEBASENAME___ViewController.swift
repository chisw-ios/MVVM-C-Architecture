//___FILEHEADER___

import UIKit

final class ___VARIABLE_productName:identifier___ViewController: BaseViewController<___VARIABLE_productName:identifier___ViewModel> {
    // MARK: - Views
    private let contentView = ___VARIABLE_productName:identifier___View()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                }
            }
            .store(in: &cancellables)
    }
}
