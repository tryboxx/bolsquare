//
//  ViewModel.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

@MainActor
protocol ViewModel: AnyObject, CanGoBack, CanClose {}

@MainActor
protocol ViewModelDelegate: AnyObject {}

@MainActor
class ViewModelImpl: ViewModel {
    var onGoBack: (() -> Void)?
    var onClose: (() -> Void)?

    lazy var headerConfiguration = prepareHeaderConfiguration()

    func prepareHeaderConfiguration() -> HeaderConfiguration {
        HeaderConfiguration(
            type: .compact,
            title: (self as? HasAppScreen)?.screen.headerTitle,
            backAction: canGoBack() ? { [weak self] in self?.onGoBack?() } : nil,
            closeAction: canClose() ? { [weak self] in self?.onClose?() } : nil
        )
    }

    func reloadHeaderConfiguration() {
        headerConfiguration = prepareHeaderConfiguration()
    }

    func canGoBack() -> Bool {
        true
    }

    func canClose() -> Bool {
        false
    }
}

@MainActor
protocol CanGoBack: AnyObject {
    var onGoBack: (() -> Void)? { get set }
    func canGoBack() -> Bool
}

@MainActor
protocol CanClose: AnyObject {
    var onClose: (() -> Void)? { get set }
    func canClose() -> Bool
}
