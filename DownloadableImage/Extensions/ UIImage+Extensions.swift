//
//   UIImage+Extensions.swift
//  DownloadableImage
//
//  Created by Максим Герасимов on 23.11.2024.
//

import UIKit

extension UIImage {
    func makeCircular() -> UIImage {
        let minSide = min(size.width, size.height)
        let rect = CGRect(x: 0, y: 0, width: minSide, height: minSide)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        UIBezierPath(ovalIn: rect).addClip()
        draw(in: CGRect(x: -((size.width - minSide) / 2), y: -((size.height - minSide) / 2), width: size.width, height: size.height))
        let circularImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return circularImage ?? self
    }

    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
