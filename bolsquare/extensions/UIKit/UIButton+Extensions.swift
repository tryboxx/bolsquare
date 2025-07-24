//
//  UIButton+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIButton {
    convenience init(
        image: UIImage,
        activeImage: UIImage? = nil,
        disabledImage: UIImage? = nil
    ) {
        self.init()
        setImage(image, for: .normal)
        setImage(activeImage, for: .highlighted)
        setImage(activeImage, for: .selected)
        setImage(disabledImage, for: .disabled)
    }
}

extension UIButton.Configuration {
    static func with(
        contentInsets: UIEdgeInsets,
        baseBackgroundColor: UIColor = .clear,
        titlePadding: CGFloat? = nil,
        imagePadding: CGFloat? = nil
    ) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(withInsets: contentInsets)
        configuration.baseBackgroundColor = baseBackgroundColor

        if let titlePadding {
            configuration.titlePadding = titlePadding
        }

        if let imagePadding {
            configuration.imagePadding = imagePadding
        }

        return configuration
    }
}

extension NSDirectionalEdgeInsets {
    init(withInsets insets: UIEdgeInsets) {
        self.init(
            top: insets.top,
            leading: insets.left,
            bottom: insets.bottom,
            trailing: insets.right
        )
    }
}
