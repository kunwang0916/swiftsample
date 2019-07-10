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
    let cache = NSCache<NSURL, UIImage>()
    // avoid multiple load for same url
    var callBackMap = [URL:[WKCompletionBlock]]()
    // LRU order
    var cacheQueue:[URL] = []
    let sizeLimitition = 10
    var lock = NSLock()
    
    func downloadImage(_ url: URL, completion: @escaping WKCompletionBlock) {
        lock.lock()
        var callBackList = callBackMap[url] ?? []
        callBackList.append(completion)
        callBackMap[url] = callBackList
        if callBackList.count > 1 {
            print("add to pending list:", url.absoluteString)
            return
        }
        lock.unlock()
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let imgData = data,
                let image = UIImage(data: imgData) else {
                completion(nil, error)
                return
            }
            
            self?.updateLRUQueue(url, image)
            if let callBackList = self?.callBackMap.removeValue(forKey: url) {
                for cb in callBackList {
                    cb(image, nil)
                }
            }
            
        }.resume()
    }
    
    func imageForUrl(_ url: URL, completion: @escaping WKCompletionBlock) {
        // use cached image if available
        if let img = cache.object(forKey: url as NSURL) {
            print("hit cache:", url.absoluteString)
            updateLRUQueue(url, img)
            completion(img, nil)
            return
        }
        
        // download if cache not existing
        downloadImage(url, completion: completion)
    }
    
    func updateLRUQueue(_ url: URL, _ image: UIImage) {
        lock.lock()
        
        cache.setObject(image, forKey: url as NSURL)
        
        cacheQueue = cacheQueue.filter({ (elementUrl: URL) -> Bool in
            return elementUrl != url
        })
        
        cacheQueue.append(url)
        // keep LRU cache size
        while cacheQueue.count > sizeLimitition {
            let url = cacheQueue.removeFirst()
            cache.removeObject(forKey: url as NSURL)
        }
        
        lock.unlock()
    }
}
