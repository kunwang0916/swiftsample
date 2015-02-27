//
//  HealthKitViewController.swift
//  swift sample
//
//  Created by wangkun on 15/2/26.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitViewController: BaseViewController,  UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var tableView: UITableView!
    
    var healthDatas: NSArray = NSArray()
    var healthStore : HKHealthStore!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthStore = HKHealthStore()
        
        healthDatas = [HKQuantityTypeIdentifierBodyMass,]
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        
        requestAuthorization()

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
        return  healthDatas.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = healthDatas[indexPath.row] as NSString
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        var cellTitle = cell?.textLabel?.text
        println("cell title: \(cellTitle)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //request authorization for acccess healthkit data
    private func requestAuthorization() {
        
        
        // BodyMass type
        let typeOfWrite = [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
        ]
        //only writing on BodyMass data to healthkit
        let typeOfWrites = NSSet(array: typeOfWrite)
        
        
        //read BodyMass & DateOfBirth from healthkit
        let typeOfRead = [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
        ]
        let typeOfReads = NSSet(array: typeOfRead)
        
        //request authorization
        self.healthStore.requestAuthorizationToShareTypes(typeOfWrites, readTypes: typeOfReads, completion: {
            (success: Bool, error: NSError!) in
            if success {
                println("Success!")
                self.readData()
                self.writeData(180)
            } else {
                self.showSimpleAlertView("Notice", AndMessage: "To enable HealthKit, you need to add Apple id account that is enrolled in a Developer Program.")
            }
        })

    }
    
    
    
    
    /*
    loading a Body mass Quantity Samples from healthKit
    */
    private func readData() {
        var error: NSError?
        
        let typeOfWeight = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        let calendar: NSCalendar! = NSCalendar.currentCalendar()
        let now: NSDate = NSDate()
        let startDate: NSDate = calendar.startOfDayForDate(now)
        let endDate: NSDate = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: 1, toDate: startDate, options: nil)!
        
        let predicate: NSPredicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: HKQueryOptions.StrictStartDate)
        
        
        let statsOptions: HKStatisticsOptions = (HKStatisticsOptions.DiscreteMin | HKStatisticsOptions.DiscreteMax)
        
        
        
        let query: HKStatisticsQuery = HKStatisticsQuery(quantityType: typeOfWeight,
            quantitySamplePredicate: predicate, options: statsOptions, completionHandler: {
                (query: HKStatisticsQuery!, result: HKStatistics!, error: NSError!) in
                dispatch_async(dispatch_get_main_queue(),{
                    println("min:\(result.minimumQuantity()) ,max:\(result.maximumQuantity())")
                })
        })
        
        
        
        self.healthStore.executeQuery(query)
        
    }
    
    /*
    Save a Body mass Quantity Sample to healthKit
    */
    private func writeData(weight:Double){
        
        // create a data type
        let typeOfWeight = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        // add weight value
        let weightQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: weight)
        //  create a QuantitySample
        let weightSample = HKQuantitySample(type: typeOfWeight, quantity: weightQuantity, startDate: NSDate(), endDate: NSDate())
        
        // Save Data
        self.healthStore.saveObject(weightSample, withCompletion: {
            (success: Bool, error: NSError!) in
            if success {
                NSLog("Success!")
            } else {
                println("Error!")
            }
        })
        
    }

}
