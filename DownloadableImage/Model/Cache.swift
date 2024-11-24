//
//  Cache.swift
//  DownloadableImage
//
//  Created by Максим Герасимов on 23.11.2024.
//

import UIKit

class MemoryCache {
    static let shared = MemoryCache()
    private let cache = NSCache<NSString, UIImage>()

    func save(image: UIImage?, forKey key: String) {
        guard let image = image else { return }
        cache.setObject(image, forKey: key as NSString)
    }

    func load(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

class DiskCache {
    static let shared = DiskCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    init() {
        cacheDirectory = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    func save(image: UIImage?, forKey key: String) {
        guard let image = image, let data = image.pngData() else { return }
        let fileURL = cacheDirectory.appendingPathComponent(key)
        try? data.write(to: fileURL)
    }

    func load(forKey key: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
}
