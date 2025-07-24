//
//  HeaderCell.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

// MARK: - estimating height
extension HeaderCell {
    class func estimateHeight(
        forAvailableWidth availableWidth: CGFloat,
        definition: HeaderDefinition,
        contentInsets: ContentInsets
    ) -> CGFloat {
        HeaderView.estimateHeight(
            forAvailableWidth: estimateAvailableContentWidth(
                ifParentHas: availableWidth,
                contentInsets: definition.customContentInsets ?? contentInsets
            ),
            definition: definition
        )
    }
}
