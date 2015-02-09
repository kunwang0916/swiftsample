//
//  BasicUIViewController.swift
//  swiftsample
//
//  Created by wangkun on 14/11/17.
//  Copyright (c) 2014年 wangkun. All rights reserved.
//

import UIKit

class BasicUIViewController: BaseViewController {

    var label : UILabel = UILabel()
    var button : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var segment : UISegmentedControl = UISegmentedControl(items: ["Alert","ActionSheet"])
    var imageView : UIImageView = UIImageView(image: UIImage(named: "swift_logo.png"))
    var stepper : UIStepper = UIStepper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. 
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Basic UI"
        
        self.initSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Init Of SubViews
    func initSubViews() {
        //button 
        self.createLabel()
        
        //lable
        self.createButton()
        
        //SegmentedControl
        self.createSegmentedControl()
        
        //ImageView
        self.createImageView()
        
        //step 
        self.createStepper()
    }
    
    // MARK: - UILable
    func createLabel() {

        //let label : UILabel = UILabel(frame: CGRectMake(0, 80, 100, 25))
        label.frame = CGRectMake(5, 80, 100, 25)
        
        label.text = "Hello!!"
        
        label.textColor = UIColor.blackColor()
        
        label.backgroundColor = UIColor.orangeColor()
        
        label.layer.masksToBounds = true
        
        label.layer.cornerRadius = 20.0
        
        label.shadowColor = UIColor.grayColor()
        
        label.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(label)
    }
    
    // MARK: - UIButton
    func createButton() {
        
        //let button : UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        var buttonFrame : CGRect = CGRectMake(label.rightEdge + 10, label.frame.origin.y, 200, label.frame.size.height) as CGRect

        button.frame = buttonFrame
        
        button.setTitle("Click to Hello Back", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "buttonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.layer.borderWidth = 2;
        
        self.view.addSubview(button)
    }
    
    func buttonClicked() {
        self.showAlertToHelloBack()
    }
    
    // MARK: - UIAlertController
    func showAlertToHelloBack() {
        var alertStyle : UIAlertControllerStyle = UIAlertControllerStyle.Alert
        if ( segment.selectedSegmentIndex == 1)
        {
            alertStyle = UIAlertControllerStyle.ActionSheet
        }
        
        let alertControl : UIAlertController = UIAlertController(title: "Swift", message: "hello~!", preferredStyle: alertStyle)
        
        let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) in
        })
        
        alertControl.addAction(alertOkAction)
        
        
        // show alert
        self.presentViewController(alertControl, animated: true) { () -> Void in
            
        }
    }
    
    // MARK: - UISegmentedControl
    func createSegmentedControl() {
        segment.frame = CGRectMake(label.frame.origin.x, label.bottomEdge + 5, 300, 50)
        
        segment.addTarget(self, action: "segmentControlChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        segment.selectedSegmentIndex = 0
        
        self.view.addSubview(segment)
    }
    
    func segmentControlChanged() {
        println("segment changed to : \(segment.selectedSegmentIndex)")
    }
    
    // MARK: - UIImageView
    func createImageView(){
        var imageWith : CGFloat = 200
        var imageViewFrame : CGRect = CGRectMake(self.view.center.x - (imageWith / 2), segment.bottomEdge + 5, imageWith, imageWith)
        
        imageView.frame = imageViewFrame
//        imageView.image = UIImage(named: "swift_logo.png")
        
        self.view.addSubview(imageView)
    }

    func createStepper(){
        
        var stepperFrame = stepper.frame
        stepperFrame.origin.x = self.view.center.x - (stepper.frame.size.width / 2)
        stepperFrame.origin.y = imageView.bottomEdge + 5
        stepper.frame = stepperFrame
        
        stepper.minimumValue = 0
        stepper.maximumValue = 6
        stepper.value = stepper.maximumValue
        
        stepper.addTarget(self, action: "stepperValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(stepper)
    }
    
    func stepperValueChanged(){
        println("stepper ValueChanged to : \(stepper.value)")
        var alpha = (stepper.value / (stepper.maximumValue - stepper.minimumValue))
        
        imageView.alpha = CGFloat(alpha)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
