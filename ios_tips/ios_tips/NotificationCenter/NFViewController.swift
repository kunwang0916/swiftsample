//
//  NFViewController.swift
//  ios_tips
//
//  Created by roosky on 6/20/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class NFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // won't get
        self.sendNotification()
        
        self.registerForNotification();
        
        // will get
        self.sendNotification()
        
        self.unregisterForNotification()
        
        // won't get
        self.sendNotification()
    }

    
    @objc func notifiCallBack() {
        print("notifiCallBack")
    }
    
    func registerForNotification() {
        WKNotificationCenter.center.addObserver(forName: .Notifcation1, object: self, selector: #selector(notifiCallBack))
    }
    
    func unregisterForNotification() {
        WKNotificationCenter.center.removeObserver(self)
    }
    
    func sendNotification() {
        let noti = WKNotification(name: .Notifcation1, object: nil, userInfo: nil)
        WKNotificationCenter.center.post(noti)
    }

}
