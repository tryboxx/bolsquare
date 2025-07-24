//
//  UITextField+Style.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UITextField {
    func styleTextField(_ style: CompoundStyle) {
        style.textColor.map { self.textColor = $0 }
        style.font.map { self.font = $0 }
        style.textAlignment.map { self.textAlignment = $0 }
    }
}
