//
//  DynamicAnimationViewController.swift
//  swift sample
//
//  Created by wangkun on 15/2/24.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit

class DynamicAnimationViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    var animationArray: NSArray = NSArray()
    var animationView: DynamicAnimationView?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationArray = [
            "UIGravityBehavior",
        "UISnapBehavior",
        "UIPushBehavior",]
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        animationView = DynamicAnimationView(frame: CGRectMake(20, 20, 100, 100))
        animationView?.backgroundColor = UIColor.redColor()
        self.view.addSubview(animationView!)
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return  animationArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = animationArray[indexPath.row] as NSString
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        var cellTitle = cell?.textLabel?.text
        println("cell title: \(cellTitle)")
        
        if cellTitle == "UIGravityBehavior"
        {
            animationView?.gravityAnimation()
        }
        else if cellTitle == "UIPushBehavior"
        {
            animationView?.pushAnimation()
        }
        else if cellTitle == "UISnapBehavior"
        {
            animationView?.snapAnimation()
        }
    }
}
