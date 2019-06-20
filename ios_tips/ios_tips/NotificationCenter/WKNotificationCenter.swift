//
//  WKNotificationCenter.swift
//  ios_tips
//
//  Created by roosky on 6/19/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

struct  WKNotification {
    let name: WKNotification.Name
    let object: Any?
    let userInfo: [AnyHashable : Any]?
    
    enum Name {
        case Notifcation1
    }
}


struct WKNotificationObserver {
    let notificationName: WKNotification.Name
    let obj: NSObject
    let selector: Selector
}

class WKNotificationCenter: NSObject {
    static let center = WKNotificationCenter()
    var observers = [WKNotificationObserver]()
    
    
    func removeObserver(_ observer: NSObject) {
        self.observers.removeAll { ( no : WKNotificationObserver) -> Bool in
            return  no.obj == observer
        }
    }

    func post(_ notification: WKNotification) {
        for ob in observers {
            if ob.notificationName == notification.name {
                ob.obj.perform(ob.selector)
            }
        }
    }
    
    func addObserver(forName name: WKNotification.Name,
                     object obj: NSObject,
                     selector: Selector) {
        let ob = WKNotificationObserver(notificationName: name, obj: obj, selector: selector)
        observers.append(ob)
    }
}
