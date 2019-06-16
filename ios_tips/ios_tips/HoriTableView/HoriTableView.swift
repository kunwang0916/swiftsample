//
//  HoriTableView.swift
//  ios_tips
//
//  Created by roosky on 6/16/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

protocol HoriViewDataSource: NSObjectProtocol {
    func horiView(_ horiView: HoriTableView, numOfColsInSection section: Int) -> Int
    func horiView(_ horiView: HoriTableView, cellForColAt indexPath: IndexPath) -> UITableViewCell
}

protocol HoriViewDelegate: NSObjectProtocol {
}

struct Default {
    static let RowWidth = 100.0
}

class HoriTableView: UIScrollView {

    var _cachedCells:[NSIndexPath: UITableViewCell] = [:]
    var _reusableCells:Set<UITableViewCell> = []
    
    weak var dataSource: HoriViewDataSource? {
        didSet {
            self.reloadData()
            self._layoutTableView()
        }
    }
    
    weak var deletage: HoriViewDelegate?
    
    func reloadData() {
        
    }
    
    private func _layoutTableView() {
        let cellNum = self.dataSource?.horiView(self, numOfColsInSection: 0) ?? 0
        // calculate the content size
        var contentSize = self.bounds.size
        contentSize.width = CGFloat(Double(cellNum) * Default.RowWidth)
        self.contentSize = contentSize
        var visiableRect = self.bounds
        visiableRect.origin = self.contentOffset
        for i in 0..<cellNum {
            let ip = IndexPath(row: i, section: 0)
            let cellRect = self._rectForIndexPath(ip)
            if (visiableRect.intersects(cellRect)) {
                if let cell = self.dataSource?.horiView(self, cellForColAt: ip) {
                    cell.frame = cellRect
                    self.addSubview(cell);
                }
            }
        }
    }
    
    private func _rectForIndexPath(_ indexPath: IndexPath) -> CGRect {
        let x = Double(indexPath.row) * Default.RowWidth
        let rect = CGRect(x: CGFloat(x),
                          y: CGFloat(0.0),
                          width: CGFloat(Default.RowWidth),
                          height: CGFloat(self.bounds.size.height))
        return rect
    }
    
    override func layoutSubviews() {
        self._layoutTableView()
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
