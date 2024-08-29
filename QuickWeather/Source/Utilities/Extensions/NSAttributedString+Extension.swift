//
//  NSAttributedString+Extension.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 29/08/2024.
//

import UIKit

extension NSAttributedString {
    
    /// Appends another `NSAttributedString` to the current instance and returns the resulting `NSAttributedString`.
    func appending(
        _ attributedString: NSAttributedString
    ) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
        mutableAttributedString.append(attributedString)
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    /// Appends an image to the current `NSAttributedString` and returns the resulting `NSAttributedString`.
    /// - Parameters:
    ///   - image: The `UIImage` to be appended.
    ///   - imageHeight: Optional height for the image. If not provided, the font's height is used.
    func appending(
        image: UIImage,
        imageHeight: CGFloat? = nil
    ) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let font = (self.attributes(at: 0, effectiveRange: nil)[.font] as? UIFont) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let height = imageHeight ?? font.lineHeight
        
        attachment.bounds = CGRect(
            x: 0,
            y: (font.capHeight - height).rounded() / 2,
            width: height,
            height: height
        )
        
        let imageAttributedString = NSMutableAttributedString(attachment: attachment)
//        imageAttributedString.addAttribute(
//            .foregroundColor,
//            value: UIColor.mainTheme,
//            range: NSRange(location: 0, length: imageAttributedString.length)
//        )
        
        let resultAttributedString = NSMutableAttributedString(attributedString: self)
        resultAttributedString.append(NSAttributedString(string: "\u{00a0}"))
        resultAttributedString.append(imageAttributedString)
        
        return resultAttributedString
    }
}
