//
//  util.swift
//  swiftsample
//
//  Created by wangkun on 14/11/17.
//  Copyright (c) 2014年 wangkun. All rights reserved.
//

import UIKit

extension UIView {
    var rightEdge: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }

    var bottomEdge: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
}