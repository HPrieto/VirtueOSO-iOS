//
//  UIImageView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

fileprivate var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>();

extension UIImageView {

    func download(from urlString: String) {

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let newImage = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                imageCache.setObject(newImage, forKey: urlString as NSString)
                self.image = newImage
            }
        }
    }

}
