//
//  TextSpeechViewController.swift
//  swift sample
//
//  Created by wangkun on 15/2/24.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit
import AVFoundation

class TextSpeechViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var textTable: UITableView!
    var textArray : NSArray = NSArray()

    override func viewDidLoad() {
        //NOTICE Only Support english and the user’s language and region preferences selected in the Settings app. 
        textArray = ["你好, 这是text speech的demo。",
            "Hello, this is a demo for text speech.",
            "こんにちは,text speechのデモです。",
            "안녕하세요, 텍스트 음성에 대한 데모입니다",
            "Ciao, questa è una demo per il discorso di testo",
            "Привет, это демо-версию для текста речи",
            "Bonjour, ce est une démo pour la parole de texte",
            "Hola, este es un demo para el discurso de texto",
            "Hallo, hier ist eine Demo für Text Rede",]
        
        self.textTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
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
        return  textArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = textArray[indexPath.row] as NSString
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        var cellTitle = cell?.textLabel?.text
        println("cell title: \(cellTitle)")
        self.speechForString(cellTitle!)
    }
    
    func speechForString(textString : NSString){
        var utterance = AVSpeechUtterance(string: textString) as AVSpeechUtterance
        var synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }
}
