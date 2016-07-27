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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outfitImg.image = image
    }
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
