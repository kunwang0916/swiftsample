//
//  WKImageView.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class WKImageView: UIImageView {
    var imageUrl: URL?
    func wk_setImage(with url: URL) {
        self.imageUrl = url
        self.image = nil
        self.contentMode = .scaleAspectFit
        
        WKWebImageManager.shared.imageForUrl(url, completionHandler: { [weak self] (img: UIImage?, err: Error?) -> Void in
            if let img = img {
                // key point: don't forget change UI in main thread
                if url == self?.imageUrl {
                    DispatchQueue.main.async {
                        self?.image = img
                    }
                }
            } else if let err = err {
                print(err)
            }
        })
        
    }
}
