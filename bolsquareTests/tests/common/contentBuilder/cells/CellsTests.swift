//
//  CellsTests.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import XCTest
import Nimble
import Nimble_Snapshots

@testable import bolsquare

class CellsTests: BaseTestCase {

    func testLabelWithValueCell() {

        let parent = TableViewCellSnapshotContainer<LabelWithValueCell>(width: 400) { cell in
            let definition = LabelWithValueDefinition(name: "Name", value: "Value")
            cell.configure(withDefinition: definition)
        }

        expect(parent) == snapshot()
    }
}
