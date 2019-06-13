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
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                var jsonDic:NSDictionary = json!
                // output every key&value in json
                for (jsonKey, jsonValue) in jsonDic{
                    println("\(jsonKey): \(jsonValue)")
                }
            }
            
        }
        
        //do the request
        task.resume()
    }
}
