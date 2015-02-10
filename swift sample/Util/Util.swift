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

extension UIViewController {

    func showSimpleAlertView(alertTitle: NSString?, AndMessage alertMessage:NSString?){
        var alertStyle : UIAlertControllerStyle = UIAlertControllerStyle.Alert
        
        let alertControl : UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        
        let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) in
        })
        
        alertControl.addAction(alertOkAction)
        
        
        // show alert
        self.presentViewController(alertControl, animated: true) { () -> Void in
            
        }
        
    }
}