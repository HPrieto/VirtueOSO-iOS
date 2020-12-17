//
//  UIImageView+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

fileprivate var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>();

extension UIImage {
    
    static func get(fromUrlString urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completionHandler(cachedImage)
            return
        }
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        DispatchQueue.global().async {
            guard
                let data = try? Data(contentsOf: url),
                let newImage = UIImage(data: data)
            else {
                completionHandler(nil)
                return
            }
            DispatchQueue.main.async {
                imageCache.setObject(newImage, forKey: urlString as NSString)
                completionHandler(newImage)
            }
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
