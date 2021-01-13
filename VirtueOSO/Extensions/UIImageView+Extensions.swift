//
//  UIImageView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImage {
    
    static func get(fromUrlString urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().sync {
            if let cachedImage: UIImage = imageCache.object(forKey: urlString as NSString) {
                DispatchQueue.main.async {
                    completionHandler(cachedImage)
                }
                return
            }
            guard
                let url: URL = URL(string: urlString),
                let data: Data = try? Data(contentsOf: url),
                let image: UIImage = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
            imageCache.setObject(image, forKey: urlString as NSString)
        }
    }
}

extension UIImageView {
    
    public func round(imageViewCorners corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func setTestImage() {
        setImage(fromUrlString: "https://i.pinimg.com/originals/88/c7/29/88c729e877cdfc06da1dd8149094e7fe.jpg")
    }
    
    func setTestEventImage() {
        setImage(fromUrlString: "https://i.insider.com/576bf03552bcd020008cb17b?width=1136&format=jpeg")
    }

    func setImage(fromUrlString urlString: String) {

        UIImage.get(fromUrlString: urlString) { [weak self] (image) in
            guard
                let `self` = self,
                let image = image
            else {
                return
            }
            self.image = image
        }
    }
    
    convenience init(sfSymbol: UIImage.SFSymbol, weight: UIImage.SymbolWeight) {
        self.init()
        let image: UIImage? = UIImage(sfSymbol: sfSymbol, withWeight: weight)?.withRenderingMode(.alwaysTemplate)
        self.image = image
    }

}
