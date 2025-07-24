//
//  GenericContentCell.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol ViewWithDefinition: UIView {
    associatedtype Definition: ContentItemDefinition
    func configure(withDefinition definition: Definition)
}

class GenericContentCell<Definition, View: ViewWithDefinition>: ContentCell<Definition> where View.Definition == Definition {
    var onAction: (() -> Void)?

    let view = View().withoutResizingMask()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        container.addSubview(view)
        view.applyLayout(Layouts.view)
    }

    override func configure(withDefinition definition: Definition) {
        super.configure(withDefinition: definition)
        view.configure(withDefinition: definition)
    }
}

private enum Layouts {
    static let view = Layout(parent: layoutPinAll)
}
