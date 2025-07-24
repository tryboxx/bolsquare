//
//  HasDynamicHeight.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol HasDynamicHeight: AnyObject {
    var onHeightChanged: (() -> Void)? { get set }
}

protocol IsExpandable: HasDynamicHeight {
    var onStateChanged: ((Bool) -> Void)? { get set }
    var isExpanded: Bool { get }
    var shouldCollapseOthers: Bool { get }

    func setIsExpanded(_: Bool)
}
