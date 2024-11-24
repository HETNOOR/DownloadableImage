//
//  Downloadable.swift
//  DownloadableImage
//
//  Created by Максим Герасимов on 23.11.2024.
//

import UIKit

protocol Downloadable {
    func loadImage(from url: URL, withOptions: [DownloadOptions])
}

extension Downloadable where Self: UIImageView {
    func loadImage(from url: URL, withOptions: [DownloadOptions]) {
        let uniqueOptions = Array(Set(withOptions))
        let cacheKey = url.absoluteString + uniqueOptions.map { "\($0)" }.joined()

        if let cachedImage = MemoryCache.shared.load(forKey: cacheKey) {
            self.image = cachedImage
            return
        } else if let cachedImage = DiskCache.shared.load(forKey: cacheKey) {
            self.image = cachedImage
            MemoryCache.shared.save(image: cachedImage, forKey: cacheKey)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            var processedImage: UIImage?

            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                processedImage = image
            } else {
                print("Ошибка загрузки изображения.")
                return
            }

            for option in uniqueOptions {
                switch option {
                case .circle:
                    processedImage = processedImage?.makeCircular()
                case .resize:
                    let viewSize = self.bounds.size
                    processedImage = processedImage?.resize(to: viewSize)
                case .cached(let from):
                    switch from {
                    case .disk:
                        DiskCache.shared.save(image: processedImage, forKey: url.absoluteString)
                    case .memory:
                        MemoryCache.shared.save(image: processedImage, forKey: url.absoluteString)
                    }
                }
            }

            if let finalImage = processedImage {
                MemoryCache.shared.save(image: finalImage, forKey: cacheKey)
                DiskCache.shared.save(image: finalImage, forKey: cacheKey)
            }

            DispatchQueue.main.async {
                self.image = processedImage
            }
        }
    }
}
