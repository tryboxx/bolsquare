//
//  ImageCache.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

final class ImageCache {

    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func store(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
