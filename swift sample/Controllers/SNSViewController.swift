//
//  SNSViewController.swift
//  swift sample
//
//  Created by wangkun on 15/2/9.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit
import Social

class SNSViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    var snsTypeArray: NSArray = NSArray()
    @IBOutlet weak var snsTableView: UITableView!
    
    
    override func viewDidLoad() {
        self.title = "SNS"
        
        snsTypeArray = ["Facebook","Twitter","Sina","Tencent"]
        
        self.snsTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    //MARK:-  UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return snsTypeArray.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->     UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(snsTypeArray.objectAtIndex(indexPath.row))"
        return cell
    }
    
    //MARK:-  UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        NSLog("\(cell?.textLabel?.text)")
        
        if cell?.textLabel?.text == "Facebook"{
            self.shareSNSByType(SLServiceTypeFacebook)
        }
        else if cell?.textLabel?.text == "Twitter"{
            self.shareSNSByType(SLServiceTypeTwitter)
        }
        else if cell?.textLabel?.text == "Sina"{
            self.shareSNSByType(SLServiceTypeSinaWeibo)
        }
        else if cell?.textLabel?.text == "Tencent"{
            self.shareSNSByType(SLServiceTypeTencentWeibo)
        }
    }
    
    //MARK:-  SNS
    func shareSNSByType(snsType: NSString){
        if SLComposeViewController.isAvailableForServiceType(snsType){
            var slcc = SLComposeViewController(forServiceType: snsType)
            slcc.setInitialText("SNS test")
            self.presentViewController(slcc, animated: true, completion: { () -> Void in
                
            })
        }else{
            let alertControl : UIAlertController = UIAlertController(title: "SNS NG", message: "Can't use this sns right now~!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                (action: UIAlertAction!) in
            })
            
            alertControl.addAction(alertOkAction)
            
            
            // show alert
            self.presentViewController(alertControl, animated: true, completion: { () -> Void in
                //
            })
        }
    }
}
