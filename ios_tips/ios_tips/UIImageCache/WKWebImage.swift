//
//  WKWebImage.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

/**
 a naive solution for UIImage on memory LRU cache.
 **/
import UIKit

typealias WKCompletionBlock = (UIImage?, Error?) -> Void

class WKWebImageManager: NSObject {
    static let shared = WKWebImageManager()
    // cached image
    var imageCache:[URL: UIImage] = [:]
    // LRU order
    var cacheQueue:[URL] = []
    let sizeLimitition = 10
    
    func downloadImage(_ url: URL, completionHandler: @escaping WKCompletionBlock) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imgData = data,
                let image = UIImage(data: imgData) else {
                completionHandler(nil, error)
                return
            }
            
            self.updateLRUQueue(url, image)
            completionHandler(image, nil)
        }.resume()
    }
    
    func imageForUrl(_ url: URL, completionHandler: @escaping WKCompletionBlock) {
        // use cached image if available
        if let img = self.imageCache[url] {
            self.updateLRUQueue(url, img)
            completionHandler(img, nil)
            return
        }
        
        // download if cache not existing
        self.downloadImage(url, completionHandler: completionHandler)
    }
    
    func updateLRUQueue(_ url: URL, _ image: UIImage) {
        self.imageCache[url] = image
        self.cacheQueue = self.cacheQueue.filter({ (elementUrl: URL) -> Bool in
            return elementUrl != url
        })
        
        self.cacheQueue.append(url)
        // keep LRU cache size
        while self.cacheQueue.count > self.sizeLimitition {
            let url = self.cacheQueue.removeFirst()
            self.imageCache.removeValue(forKey: url)
        }
    }
}

extension UIImageView {
    func wk_setImage(with url: URL) {
        self.contentMode = .scaleAspectFit
        WKWebImageManager.shared.imageForUrl(url, completionHandler: { [weak self] (img: UIImage?, err: Error?) -> Void in
            if let img = img {
                // key point: don't forget change UI in main thread
                DispatchQueue.main.async {
                    self?.image = img
                }
            } else if let err = err {
                print(err)
            }
        })
    }
}
