//
//  PhotoKitViewController.swift
//  swiftsample
//
//  Created by wangkun on 15/2/8.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

import UIKit
import Photos

class PhotoKitViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func pickPhotoButtonClicked(sender: UIButton) {
        //choose a source
        let alertControl : UIAlertController = UIAlertController(title: "Choose", message: "Choose photo source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) in
            self.showImagePickerWithSourceType(UIImagePickerControllerSourceType.Camera)
        })
        alertControl.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) in
            self.showImagePickerWithSourceType(UIImagePickerControllerSourceType.PhotoLibrary)
        })
        alertControl.addAction(albumAction)
        
        //
        let alertCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (action: UIAlertAction!) in
            
        })
        alertControl.addAction(alertCancelAction)
        
        // show alert
        self.presentViewController(alertControl, animated: true) { () -> Void in
            
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func showImagePickerWithSourceType(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            var imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: { () -> Void in
                
            })
        }else{
            self.showSimpleAlertView("NG", AndMessage: "Source is not available!")
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        let image = info[UIImagePickerControllerEditedImage] as UIImage
        imageView.image = image
        
        let imageUrl = info[UIImagePickerControllerReferenceURL] as NSURL

        let fetchResult = PHAsset.fetchAssetsWithALAssetURLs([imageUrl], options: nil)
        let asset = fetchResult.firstObject as PHAsset
        
        NSLog("\(asset)")
        NSLog("\(asset.favorite)")
        NSLog("size : (\(asset.pixelWidth),\(asset.pixelHeight)) ")

        let modificationDateString = NSDateFormatter.localizedStringFromDate(asset.modificationDate, dateStyle: NSDateFormatterStyle.FullStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        NSLog("modificationDate : \(modificationDateString)")
        
        let creationDateString = NSDateFormatter.localizedStringFromDate(asset.creationDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.FullStyle)
        NSLog("creationDate : \(creationDateString) ")

        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
}
