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
    static let ColWidth = 200.0
    static let SeperatorWidth = 2.0
    static let UnitWidth = ColWidth + SeperatorWidth
}

class HoriTableView: UIScrollView {

    var _cachedCells:[IndexPath: UITableViewCell] = [:]
    var _reusableCells:Set<UITableViewCell> = []
    
    weak var dataSource: HoriViewDataSource? {
        didSet {
            self._layoutTableView()
        }
    }
    
    weak var deletage: HoriViewDelegate?
    
    private func _layoutTableView() {
        let cellNum = self.dataSource?.horiView(self, numOfColsInSection: 0) ?? 0
        // calculate the content size
        var contentSize = self.bounds.size
        contentSize.width = CGFloat(Double(cellNum) * Default.UnitWidth)
        self.contentSize = contentSize
        
        // calculate visiable bounds
        var visiableBounds = self.bounds
        visiableBounds.origin = self.contentOffset
        
        var preCachedCells = self._cachedCells
        self._cachedCells.removeAll()
        
        for i in 0..<cellNum {
            let ip = IndexPath(row: i, section: 0)
            let cellRect = self._rectForIndexPath(ip)
            if visiableBounds.intersects(cellRect) {
                if let cell = preCachedCells[ip] ??  self.dataSource?.horiView(self, cellForColAt: ip) {
                    cell.frame = cellRect
                    cell.backgroundColor = .red
                    self.addSubview(cell)
                    self._cachedCells[ip] = cell
                    preCachedCells.removeValue(forKey: ip)
                }
            }
        }
        
        for cell in preCachedCells.values {
            if cell.reuseIdentifier != nil {
                self._reusableCells.insert(cell)
            } else {
                cell.removeFromSuperview()
            }
        }
    }
    
    private func _rectForIndexPath(_ indexPath: IndexPath) -> CGRect {
        let x = Double(indexPath.row) * Default.UnitWidth
        let rect = CGRect(x: CGFloat(x),
                          y: CGFloat(0.0),
                          width: CGFloat(Default.ColWidth),
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
