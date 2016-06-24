//
//  ViewController.swift
//  KSModalController
//
//  Created by Kumar Saurabh on 24/06/16.
//  Copyright © 2016 Kumar Saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    // Set the presentation controller and modal transitioning class through Transitioning delegate
    let demoTransitioningDelegate = KSTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // .None for pop in iPhone
        // else it will be pop in iPad and full screen in iPhone
        return .None
    }

    // right-centre-right modal
    
    @IBAction func rcrAnimationTapped(sender: UIButton) {
       
        let storyboardName = UIStoryboard(name: "Main", bundle: nil)
        let presentedVCObj = storyboardName.instantiateViewControllerWithIdentifier("PresentationPresentedVCID") as! PresentationPresentedVC
        presentedVCObj.modalPresentationStyle = (UI_USER_INTERFACE_IDIOM() == .Phone) ? .Custom : .Popover
        presentedVCObj.animeType = AnimationType.rightCenterRightAnimation
        
        let popOverPresentationContr = presentedVCObj.popoverPresentationController
        if(UI_USER_INTERFACE_IDIOM() == .Phone) {
            presentedVCObj.transitioningDelegate = demoTransitioningDelegate
            
            // animation direction
            (presentedVCObj.transitioningDelegate! as! KSTransitioningDelegate).animationType = AnimationType.rightCenterRightAnimation.rawValue
            (presentedVCObj.presentationController as! KSPresentationController).isHorizontalTransition = true
            
            // displacement = (presentedVC width)/(screen width)
            (presentedVCObj.presentationController as! KSPresentationController).displacement = 0.8
            
            (presentedVCObj.transitioningDelegate! as! KSTransitioningDelegate).transitionDuration = 0.5
            
            // various ways to dismiss
            (presentedVCObj.presentationController as! KSPresentationController).enableTapOutsideToDismiss()
            (presentedVCObj.presentationController as! KSPresentationController).enableRightSwipeToDismiss()
            
        }else {
            
            // In iPad, it will be a pop-over
            presentedVCObj.preferredContentSize = CGSizeMake(view.frame.width/3, 120)
            popOverPresentationContr?.delegate = self
            popOverPresentationContr?.sourceView = sender
            popOverPresentationContr?.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height)
            
        }
        presentViewController(presentedVCObj, animated: true, completion: nil)
    }
    
    // bottom-centre-bottom modal
    
    @IBAction func bcbAnimationTapped(sender: UIButton) {
        
        let storyboardName = UIStoryboard(name: "Main", bundle: nil)
        let presentedVCObj = storyboardName.instantiateViewControllerWithIdentifier("PresentationPresentedVCID") as! PresentationPresentedVC
        presentedVCObj.modalPresentationStyle = (UI_USER_INTERFACE_IDIOM() == .Phone) ? .Custom : .Popover
        presentedVCObj.animeType = AnimationType.bottomCenterBottomAnimation
        
        let popOverPresentationContr = presentedVCObj.popoverPresentationController
        if(UI_USER_INTERFACE_IDIOM() == .Phone) {
            presentedVCObj.transitioningDelegate = demoTransitioningDelegate
            
            // animation direction
            (presentedVCObj.transitioningDelegate! as! KSTransitioningDelegate).animationType = AnimationType.bottomCenterBottomAnimation.rawValue
            (presentedVCObj.presentationController as! KSPresentationController).isHorizontalTransition = false
            
            // displacement = (presentedVC height)/(screen height)
            (presentedVCObj.presentationController as! KSPresentationController).displacement = 0.8
            
            (presentedVCObj.transitioningDelegate! as! KSTransitioningDelegate).transitionDuration = 0.5
            
            // various ways to dismiss
            (presentedVCObj.presentationController as! KSPresentationController).enableTapOutsideToDismiss()
            (presentedVCObj.presentationController as! KSPresentationController).enableDownSwipeToDismiss()
            
        }else {
            
            // In iPad, it will be a pop-over
            presentedVCObj.preferredContentSize = CGSizeMake(view.frame.width/3, 120)
            popOverPresentationContr?.delegate = self
            popOverPresentationContr?.sourceView = sender
            popOverPresentationContr?.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height)
            
        }
        presentViewController(presentedVCObj, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

