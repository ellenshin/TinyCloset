//
//  NewOutfitPictureSelectVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/20/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class NewOutfitPictureSelectVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        print("cancel btn pressed")
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func uploadPicture(sender: UIGestureRecognizer) {
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func takePicture(sender: UIGestureRecognizer) {
        print("tapped")
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        DataService.instance.setImage(image)
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("NewOutfitTodayVC", sender: image)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func postAlert(title: String, message: String) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewOutfitTodayVC" {
            if let newOutfitVC = segue.destinationViewController as? NewOutfitTodayVC {
                if let outfit = sender as? UIImage {
                    newOutfitVC.image = outfit
                }
            }
        }
    }
}
