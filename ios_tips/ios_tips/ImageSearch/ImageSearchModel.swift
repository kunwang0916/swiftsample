//
//  ImageSearchModel.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

struct ImageSearchModel: Codable {
    let urlStr: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case urlStr = "download_url"
        case author
    }
}

