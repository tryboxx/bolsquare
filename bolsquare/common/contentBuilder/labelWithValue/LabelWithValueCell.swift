//
//  LabelWithValueCell.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

// MARK: - estimating height
extension LabelWithValueCell {
    class func estimateHeight(
        forAvailableWidth availableWidth: CGFloat,
        definition: LabelWithValueDefinition,
        contentInsets: ContentInsets
    ) -> CGFloat {
        LabelWithValueView.estimateHeight(
            forAvailableWidth: estimateAvailableContentWidth(
                ifParentHas: availableWidth,
                contentInsets: definition.customContentInsets ?? contentInsets
            ),
            definition: definition
        )
    }
}
