//
//  WKImageCacheCell.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class WKImageCacheCell: UICollectionViewCell {
    private weak var activeView: UIActivityIndicatorView?
    private let imageView: WKImageView = {
        let iv = WKImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10.0
        iv.layer.borderWidth = 2.0
        return iv
    }()
    
    var viewModel: ImageSearchViewModel! {
        didSet {
            self.imageView.wk_setImage(with: viewModel.url)
        }
    }
    
    private struct const {
        static let borderMargin:CGFloat = 10.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubViews()
    }
    
    func setupSubViews() {
        self.contentView.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: const.borderMargin),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -const.borderMargin),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: const.borderMargin),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -const.borderMargin)
        ])
    }
    
}
