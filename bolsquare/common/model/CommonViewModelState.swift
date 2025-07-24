//
//  CommonViewModelState.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

enum CommonViewModelState: Equatable {
    case idle
    case busy(String? = nil)
    case blocked
    case failed(String? = nil)
    case done

    var isBusy: Bool {
        switch self {
        case .busy: return true
        default: return false
        }
    }
}
