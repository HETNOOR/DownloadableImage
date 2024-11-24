//
//  DownloadableImage.swift
//  DownloadableImage
//
//  Created by Максим Герасимов on 23.11.2024.
//

import Foundation

enum DownloadOptions: Hashable {
    enum From {
        case disk
        case memory
    }

    case circle
    case cached(From)
    case resize
}
