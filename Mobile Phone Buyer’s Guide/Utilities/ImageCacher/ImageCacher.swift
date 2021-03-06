//
//  ImageCacher.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

private let imageCache:NSCache<NSString, UIImage> = {
    let imageCache = NSCache<NSString, UIImage>()
      imageCache.totalCostLimit = 10*1024*1024 // Max 10MB used.
    return imageCache
}()

extension NSError {
    static func generalParsingError(domain: String) -> Error {
        return NSError(domain: domain, code: 400,
                       userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Error retrieving data", comment: "General Parsing Error Description")])
    }
}

typealias DownloadImageCompletion =  (_ image: UIImage?, _ error: Error? ) -> Void
typealias SetImageCompletion = (() -> Void)?

class ImageCaching: UIImageView {

    private(set) var currentImageURL: URL?
    private var loadingView: UIViewController?
    private var isShowIndicator: Bool = false

    final private class NilImageClientSession {
        private init() {}
        static let shared: URLSession = {
            let configuration                           = URLSessionConfiguration.default
            configuration.requestCachePolicy            = .reloadIgnoringLocalAndRemoteCacheData
            configuration.urlCache                      = nil
            return URLSession(configuration: configuration)
        }()
    }

    //MARK: - Public
    func imageCaching(url: URL,
                      contentMode mode: UIView.ContentMode = .scaleAspectFit,
                      withDownloadIndicator indicator: Bool,
                      completion: SetImageCompletion = nil) {
        clipsToBounds = true
        contentMode = mode
        self.image = UIImage(imageColor: .clear, imageSize: self.bounds.size)
        self.isShowIndicator = indicator
        self.downloadImage(url: url) { [weak self] (image, error) in
            DispatchQueue.main.async {
                if image != nil { self?.loadingView?.view.removeFromSuperview() }
                if (error != nil) { return }
                self?.image = image
                if let completion = completion {
                    completion()
                }
            }
        }
    }

    func imageCaching(link: String,
                      contentMode mode: UIView.ContentMode = .scaleAspectFit,
                      withDownloadIndicator indicator: Bool = true,
                      completion: SetImageCompletion = nil) {
        guard let url = URL(string: link) else { return }
        imageCaching(url: url, contentMode: mode, withDownloadIndicator: indicator, completion: completion)
    }


}

private extension ImageCaching {
    //MARK: - Private
    private func getCacheImage(url: URL) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        return nil
    }

    private func downloadImage(url: URL, completion: @escaping DownloadImageCompletion ) {
        currentImageURL = url
        if let cachedImage = self.getCacheImage(url: url) {
            return completion(cachedImage, nil)
        } else {
            self.isShowIndicator ? showIndicator() : nil
            DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = true }
            self.downloadData(url: url) { data, response, error in
                DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
                if let error = error {
                    return completion(nil, error)
                } else if let data = data,
                    let image = UIImage(data: data),
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image") {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    if self.currentImageURL == url {
                        return completion(image, nil)
                    } else {
                        return completion(self.getCacheImage(url: self.currentImageURL!), nil)
                    }
                } else {
                    return completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                }
            }
        }
    }

    private func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        NilImageClientSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    private func showIndicator() {
        loadingView = UIViewController().loading
        self.addSubview(loadingView!.view, attachedTo: self)
    }
}

extension UIImage {
    public convenience init?(imageColor: UIColor, imageSize: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: imageSize)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        imageColor.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
