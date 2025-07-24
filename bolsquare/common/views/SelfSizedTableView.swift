//
//  SelfSizedTableView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class SelfSizedTableView: UITableView {
    var onDataReloaded: (() -> Void)?

    var maxHeight: CGFloat = UIScreen.main.bounds.size.height

    class func createDefault() -> SelfSizedTableView {
        let view = SelfSizedTableView(frame: .zero, style: .plain).withoutResizingMask()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.bounces = false
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.clipsToBounds = false
        return view
    }

    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
        onDataReloaded?()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(
            width: contentSize.width,
            height: contentSize.height + contentInset.top + contentInset.bottom
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}
