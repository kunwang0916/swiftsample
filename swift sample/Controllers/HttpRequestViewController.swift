//
//  HttpRequestViewController.swift
//  swiftsample
//
//  Created by wangkun on 14/11/17.
//  Copyright (c) 2014年 wangkun. All rights reserved.
//

import UIKit

class HttpRequestViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Http Request"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.initSubViews()
    }
    
    
    func initSubViews() {
        var button : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        var buttonWidth = CGFloat(200.0);
        var buttonFrame : CGRect = CGRectMake((self.view.frame.width  - buttonWidth)/2, 80, buttonWidth, 40) as CGRect
        
        button.frame = buttonFrame
        
        button.setTitle("do http request", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "buttonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.layer.borderWidth = 2;
        
        self.view.addSubview(button)
    }
    
    
    func buttonClicked() {
        //set url
        let url = NSURL(string: "http://httpbin.org/get")
        
        //http request block
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding);
            println(jsonString)
            //TODO : Need implement json string parsing

            
        }
        
        //do the request
        task.resume()
    }
}
