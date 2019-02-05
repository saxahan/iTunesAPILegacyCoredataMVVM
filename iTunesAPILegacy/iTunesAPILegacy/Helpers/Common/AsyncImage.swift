//
//  AsyncImage.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 5.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit
import ObjectiveC

protocol ImageDownloadHelperProtocol {
    func download(_ url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ())
}

class ImageDownloadHelper: ImageDownloadHelperProtocol {
    let urlSession: URLSession = URLSession.shared

    static var shared: ImageDownloadHelper = {
        return ImageDownloadHelper()
    }()

    func download(_ url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
        urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(UIImage(data: data), response, error)
            } else {
                completion(nil, response, error)
            }
            }.resume()
    }
}

class AsyncImage {

    let url: URL

    var image: UIImage {
        return self.imageStore ?? placeholder
    }

    var completeDownload: ((UIImage?) -> Void)?

    private var imageStore: UIImage?
    private var placeholder: UIImage

    private let imageDownloadHelper: ImageDownloadHelperProtocol

    private var isDownloading: Bool = false

    init(url: String, placeholderImage: UIImage = #imageLiteral(resourceName: "imagePlaceholder") , imageDownloadHelper: ImageDownloadHelperProtocol) {
        self.url = URL(string: url)!
        self.placeholder = placeholderImage
        self.imageDownloadHelper = imageDownloadHelper
    }

    func startDownload() {
        if imageStore != nil {
            completeDownload?(image)
        } else {
            if isDownloading { return }
            isDownloading = true
            imageDownloadHelper.download(url, completion: { [weak self] (image, response, error) in
                self?.imageStore = image
                self?.isDownloading = false
                
                DispatchQueue.main.async {
                    self?.completeDownload?(image)
                }
            })
        }
    }
}
