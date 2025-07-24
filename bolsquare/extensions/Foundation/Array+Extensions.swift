//
//  Array+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension Array where Element: Equatable {
    func doesNotContain(_ element: Element) -> Bool {
        contains(element) == false
    }

    mutating func safeAppend(_ element: Element?) {
        if let element {
            append(element)
        }
    }
}

extension Array {

    var hasElements: Bool {
        isEmpty == false
    }

    var hasOneElement: Bool {
        count == 1
    }

    var hasMoreThanOneElement: Bool {
        count > 1
    }

    func doesNotContain(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        try contains(where: predicate) == false
    }
}

extension Array where Element: UIView {

    func findTopView(within superview: UIView) -> UIView? {
        filter { view in
            view.isHidden == false && view.frame.height > 0
        }
        .min { view1, view2 in
            let view1y = view1.convert(view1.frame, to: superview)
            let view2y = view2.convert(view2.frame, to: superview)

            return view1y.minY < view2y.minY
        }
    }
}
