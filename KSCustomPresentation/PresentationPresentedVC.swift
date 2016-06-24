//
//  PresentationPresentedVC.swift
//  KSModalController
//
//  Created by Kumar Saurabh on 24/06/16.
//  Copyright © 2016 Kumar Saurabh. All rights reserved.
//

import UIKit

class PresentationPresentedVC: UIViewController {

    var animeType: AnimationType?
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var swipeInfoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if animeType == AnimationType.bottomCenterBottomAnimation {
            infoLbl.text = " ↑ Tap outside to dismiss"
            swipeInfoLbl.text = " Swipe ↓ to dismiss"
        }else {
            infoLbl.text = " ← Tap outside to dismiss"
            swipeInfoLbl.text = " Swipe → to dismiss"
        }
    }
    
    @IBAction func dismissPresesntedVC(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
