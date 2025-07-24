//
//  FactoryMock.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

@testable import bolsquare

extension FactoryMock {

    func prepareRealContentDataSource() -> ContentDataSource {
        let contentDataSource = ContentDataSourceImpl()
        contentDataSourceReturnValue = contentDataSource
        return contentDataSource
    }
}
