//
//  ImageGridViewModel.swift
//  DownloadableImage
//
//  Created by Максим Герасимов on 23.11.2024.
//

import Combine
import Foundation

class ImageGridViewModel {
    
    @Published private(set) var imageUrls: [URL] = []

    private let baseUrls = [
        "https://randomuser.me/api/portraits/men/30.jpg",
        "https://randomuser.me/api/portraits/men/69.jpg",
        "https://randomuser.me/api/portraits/men/73.jpg",
        "https://randomuser.me/api/portraits/men/90.jpg",
        "https://randomuser.me/api/portraits/women/44.jpg",
        "https://randomuser.me/api/portraits/women/43.jpg",
        "https://randomuser.me/api/portraits/women/66.jpg",
        "https://randomuser.me/api/portraits/women/48.jpg"
    ]

    private var cancellables = Set<AnyCancellable>()

    init() {
        generateRandomImages()
    }

    func generateRandomImages() {
        // Генерация 64 случайных URL
        imageUrls = (0..<64).compactMap { _ in
            URL(string: baseUrls.randomElement()!)
        }
    }
}
