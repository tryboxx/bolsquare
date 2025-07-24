//
//  DeviceUtils.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

enum DeviceUtils {

    static var hasSafeTopArea: Bool {
        safeTopArea > 0
    }

    static var hasSafeBottomArea: Bool {
        safeBottomArea > 0
    }

    static var safeTopArea: CGFloat {
        UIApplication.shared.mainWindow()?.safeAreaInsets.top ?? 0
    }

    static var safeBottomArea: CGFloat {
        UIApplication.shared.mainWindow()?.safeAreaInsets.bottom ?? 0
    }

    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
