//
//  TouchIDViewController.swift
//  swift sample
//
//  Created by wangkun on 15/2/24.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: BaseViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkTouchID()
    }
   
    @IBAction func buttonClicked(sender: AnyObject) {
        self.checkTouchID()
    }
    
    func checkTouchID(){
        var authContext = LAContext() as LAContext
        
        if authContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            authContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Touch ID Recognition",
                reply: {(success: Bool, error: NSError!) -> Void in
                    if (success){
                        self.showSimpleAlertView("Success", AndMessage: "Yes！！")
                    }else{
                        let reasonString : String? = error.localizedDescription
                        self.showSimpleAlertView("Failed", AndMessage: reasonString)
                    }
            })
        }else{
            self.showSimpleAlertView("Failed", AndMessage: "This device is not support for Touch ID.")
        }
        
    }
}
