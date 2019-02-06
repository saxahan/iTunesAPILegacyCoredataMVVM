//
//  UIImageView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setImage(_ urlString: String, placeholderImage: UIImage? = #imageLiteral(resourceName: "item-placeholder"), closure: ((UIImage?) -> Void)? = nil) {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        else {
            image = placeholderImage
        }

        guard let url = URL(string: urlString) else {
            closure?(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                closure?(nil)
                return
            }

            guard response != nil else {
                closure?(nil)
                return
            }

            guard data != nil else {
                closure?(nil)
                return
            }

            DispatchQueue.main.async { [weak self] in
                let cache = UIImage(data: data!, scale: UIScreen.main.scale)
                imageCache.setObject(cache!, forKey: urlString as AnyObject)
                self?.image = cache
                closure?(cache)
            }
        }.resume()
    }
}
