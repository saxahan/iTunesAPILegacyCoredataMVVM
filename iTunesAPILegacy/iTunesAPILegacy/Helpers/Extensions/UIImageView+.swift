//
//  UIImageView+.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(_ urlString: String, closure: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            closure?(nil)
            return
        }

        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                debugPrint("error: \(String(describing: error))")
                closure?(nil)
                return
            }

            guard response != nil else {
                debugPrint("no response")
                closure?(nil)
                return
            }

            guard data != nil else {
                debugPrint("no data")
                closure?(nil)
                return
            }

            DispatchQueue.main.async { [weak self] in
                let dImage = UIImage(data: data!)
                self?.image = dImage
                closure?(dImage)
            }
        }.resume()
    }
}
