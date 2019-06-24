//
//  SerAPI.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class PicsumAPI: NSObject {
    private struct Const {
        static let Host = "https://picsum.photos/"
        static let SearchPhotos = "v2/list"
    }
    
    static func searchImage(_ keyWord: String, completion: @escaping ([ImageSearchModel]?, Error?) -> Void) {
        let urlStr = "\(Const.Host)\(Const.SearchPhotos)"
        guard let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                completion(nil, err)
                return
            }
            do {
                let results = try JSONDecoder().decode([ImageSearchModel].self, from: data)
                completion(results, nil)
            } catch let parsingError {
                print("parsingError", parsingError)
            }
            
        }.resume()
    }
    
}
