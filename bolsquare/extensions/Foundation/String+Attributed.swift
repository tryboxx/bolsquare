//
//  String+Attributed.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension String {
    func toAttributed() -> NSAttributedString {
        NSAttributedString(string: self)
    }

    func attributedWith(
        font: UIFont? = nil,
        color: UIColor? = nil,
        kern: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        underline: NSUnderlineStyle? = nil,
        strikethrough: NSUnderlineStyle? = nil
    ) -> NSAttributedString {

        let result = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: (self as NSString).length)

        if let color {
            result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        if let font {
            result.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }

        if let kern {
            result.addAttribute(
                NSAttributedString.Key.kern,
                value: kern,
                range: range
            )
        }

        if let lineHeight {
            let paragraph = NSMutableParagraphStyle()
            paragraph.minimumLineHeight = lineHeight
            paragraph.maximumLineHeight = lineHeight
            if let lineBreakMode {
                paragraph.lineBreakMode = lineBreakMode
            }

            if let alignment {
                paragraph.alignment = alignment
            }

            result.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: paragraph,
                range: range
            )

            // This part center the text vertically within it's lineHeight.
            // At the moment, if font lineHeight is 12, and we set paragraph line height to 18,
            // then text will be bottom aligned and there will be 6px space at the top.
            // Here we are centering it, so there is 3px above and 3px below the text.
            // This workaround works differently on iOS 16.4 and on older iOSes.
            // For 16.4 we divide by 2, for older divide by 4 :/
            if let font {
                var divideFactor = 2.0
                if #unavailable(iOS 16.4) {
                    divideFactor = 4.0
                }
                let baselineOffset = (lineHeight - font.lineHeight) / divideFactor
                result.addAttribute(
                    .baselineOffset,
                    value: baselineOffset,
                    range: range
                )
            }
        }

        if let underline {
            result.addAttribute(NSAttributedString.Key.underlineStyle, value: underline.rawValue, range: range)
        }

        if let strikethrough {
            result.addAttribute(NSAttributedString.Key.strikethroughStyle, value: strikethrough.rawValue, range: range)
        }

        return result
    }
}

extension NSAttributedString {
    func join(with second: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        result.append(second)
        return NSAttributedString(attributedString: result)
    }

    func join(with second: String) -> NSAttributedString {
        join(with: NSAttributedString(string: second))
    }

    func with(image: UIImage, x: CGFloat = 0.0, y: CGFloat = 0.0) -> NSAttributedString {
        guard let copy = mutableCopy() as? NSMutableAttributedString else { return self }
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: x, y: y, width: image.size.width, height: image.size.height)

        let attributedImage = NSAttributedString(attachment: imageAttachment)
        copy.append(attributedImage)
        return copy
    }

    // swiftlint:disable force_cast
    func withUnderline() -> NSAttributedString {
        guard let copy = mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: length)
        )
        return copy.copy() as! NSAttributedString
    }

    func with(lineHeight: CGFloat, font: UIFont?) -> NSAttributedString {
        guard let copy = mutableCopy() as? NSMutableAttributedString else { return self }
        let range = NSRange(location: 0, length: length)

        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = lineHeight
        paragraph.maximumLineHeight = lineHeight

        if let font {
            var divideFactor = 2.0
            if #unavailable(iOS 16.4) {
                divideFactor = 4.0
            }
            let baselineOffset = (lineHeight - font.lineHeight) / divideFactor
            copy.addAttribute(.baselineOffset, value: baselineOffset, range: range)
        }

        copy.addAttribute(.paragraphStyle, value: paragraph, range: range)

        return copy
    }
}

extension [NSAttributedString] {

    func joined(with separator: NSAttributedString) -> NSAttributedString {
        reduce(NSMutableAttributedString()) { restul, nextComponent in
            if restul.length > 0 {
                restul.append(separator)
            }
            restul.append(nextComponent)
            return restul
        }
    }

    func joined(with separator: String = "") -> NSAttributedString {
        self.joined(with: NSAttributedString(string: separator))
    }
}
