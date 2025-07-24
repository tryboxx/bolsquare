//
//  UITableView+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UITableView {

    func bringCellsToFrontBeginningFromLastCell() {
        var cells = [UITableViewCell]()
        let numberOfSections = numberOfSections
        for section in 0 ..< numberOfSections {
            let numberOfRows = numberOfRows(inSection: section)
            for row in 0 ..< numberOfRows {
                guard let result = cellForRow(at: IndexPath(row: row, section: section)) else {
                    continue
                }
                cells.append(result)
            }
        }
        for cell in cells {
            cell.superview?.bringSubviewToFront(cell)
        }
    }

    func fixAnimationMasksToBounds() {
        for cell in visibleCells {
            cell.layer.masksToBounds = false
            cell.contentView.layer.masksToBounds = false
        }
    }

    func addAnimationForNextReload() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 0.25
        transition.subtype = CATransitionSubtype.fromTop
        layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
    }

    func findCell<Cell: UITableViewCell>() -> Cell? {
        visibleCells
            .first(where: { $0 is Cell }) as? Cell
    }
}
