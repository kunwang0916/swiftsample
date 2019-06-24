//
//  UIImageCacheViewController.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class ImageSearchController: UICollectionViewController {
    
    private var viewModels = [ImageSearchViewModel]()
    
    private struct const {
        static let cellId = "ImageSearchControllerCell"
        static let cellSpace = 10.0
    }
    
    override func loadView() {
        super.loadView()
        self.collectionView.register(WKImageCacheCell.self, forCellWithReuseIdentifier: const.cellId)
        self.collectionView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    private func fetchData() {
        PicsumAPI.searchImage("apple") { [weak self] (searchResults, err) in
            if let err = err {
                print(err)
                return
            }
            
            self?.viewModels = searchResults?.map({return ImageSearchViewModel($0)}) ?? []
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
}


extension ImageSearchController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: const.cellId, for: indexPath) as! WKImageCacheCell
        cell.viewModel = viewModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (collectionView.bounds.size.width - CGFloat(const.cellSpace)) / 2
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(const.cellSpace)
    }
}

extension ImageSearchViewModel {
    
}
