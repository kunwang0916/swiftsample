//
//  ImageSearchViewModel.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

struct ImageSearchViewModel {
    let url: URL
    let author: String
    
    init(_ search:ImageSearchModel) {
        self.url = URL(string: search.urlStr)!
        self.author = search.author
    }
}

