//
//  UIImage+Extension.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

extension UIImage {
    
    func resized(toHeight height: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: CGFloat(ceil(height/size.height * size.width)), height: height)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
