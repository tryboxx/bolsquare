//
//  NSAttributedString+Size.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }

    func estimateWidth() -> CGFloat {
        size().width
    }

    func doesRequireMoreLines(toFitWidth maxWidth: CGFloat) -> Bool {
        let possibleHeight = size().height
        let requiredHeight = heightWithConstrainedWidth(width: maxWidth)
        return requiredHeight > possibleHeight
    }
}
