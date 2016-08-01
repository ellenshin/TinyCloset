//
//  NewOutfitTodayVC.swift
//  TinyCloset
//
//  Created by Ellen Shin on 7/20/16.
//  Copyright © 2016 Ellen Shin. All rights reserved.
//

import UIKit

class NewOutfitTodayVC: UIViewController {

    @IBOutlet weak var outfitImg: UIImageView!
    
    var image: UIImage?
    var yesOrNo: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outfitImg.image = image
    }
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "wearingTodayVC" {
            if let newVC = segue.destinationViewController as? wearingTodayVC {
                if let yesNo = sender as? Bool {
                    newVC.wearingItToday = yesNo
                }
            }
        }

        
    }
    @IBAction func yesBtnPressed(sender: AnyObject) {
        yesOrNo = true
        performSegueWithIdentifier("wearingTodayVC", sender: yesOrNo)
    }

    @IBAction func noBtnPresed(sender: AnyObject) {
        yesOrNo = false
        performSegueWithIdentifier("wearingTodayVC", sender: yesOrNo)
    }
    
}
