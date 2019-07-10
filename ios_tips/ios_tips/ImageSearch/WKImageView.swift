//
//  WKImageView.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageWithURLStr(_ str: String, completion: @escaping WKCompletionBlock) {
        guard let url = URL(string: str) else { return }
        setImageWithURL(url, completion: completion)
    }
    
    func setImageWithURL(_ url: URL, completion: @escaping WKCompletionBlock) {
        WKWebImageManager.shared.imageForUrl(url, completion: completion)
    }
}

class WKImageView: UIImageView {
    var imageURL: URL? {
        didSet {
            image = nil
            if let url = self.imageURL {
                wk_setImage(with: url)
            }
        }
    }
    
    private func wk_setImage(with url: URL) {
        setImageWithURL(url) { [weak self] (image, err) in
            guard let image = image else {
                if let err = err {
                    print(err)
                }
                
                return
            }
        
            // key point: don't forget change UI in main thread
            if url == self?.imageURL {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
