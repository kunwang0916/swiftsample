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
        self.sendNotification(.Notification1)
        
        self.registerForNotification(.Notification1);
        
        // will get
        self.sendNotification(.Notification1)
        
        //  won't get
        self.sendNotification(.Notification2)
        
        self.registerForNotification(.Notification2);
        
        // will get
        self.sendNotification(.Notification1)
        
        //  will get
        self.sendNotification(.Notification2)
        
        self.unregisterForNotification(.Notification1);
        
        // won't get
        self.sendNotification(.Notification1)
        //  will get
        self.sendNotification(.Notification2)
        
        self.unregisterForNotification(.Notification2);
        
        // won't get
        self.sendNotification(.Notification1)
        //  won't get
        self.sendNotification(.Notification2)
    }

    
    @objc func notifiCallBack() {
        print("notifiCallBack")
    }
    
    func registerForNotification(_ name: WKNotification.Name) {
        WKNotificationCenter.center.addObserver(forName: name, object: self, selector: #selector(notifiCallBack))
    }
    
    func unregisterForNotification(_ name: WKNotification.Name) {
        WKNotificationCenter.center.removeObserver(self, name)
    }
    
    func sendNotification(_ name: WKNotification.Name) {
        let noti = WKNotification(name: name, object: nil, userInfo: nil)
        WKNotificationCenter.center.post(noti)
    }

}
