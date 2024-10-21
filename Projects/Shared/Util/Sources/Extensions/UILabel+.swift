//
//  UILabel+.swift
//  SharedUtil
//
//  Created by 지연 on 10/19/24.
//

import UIKit

extension UILabel {
    public func setTextWithLineHeight(_ text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(
                string: text,
                attributes: attributes
            )
            
            self.attributedText = attrString
        }
    }
}
