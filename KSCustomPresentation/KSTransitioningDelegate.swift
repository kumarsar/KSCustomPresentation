//
//  KSTransitioningDelegate.swift
//  KSModalController
//
//  Created by Kumar Saurabh on 18/12/15.
//  Copyright © 2015 Kumar Saurabh. All rights reserved.
//

import UIKit

class KSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var animationType:String?
    var transitionDuration:CGFloat?
    var isInteractiveTransition:Bool = false

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let pController = KSPresentationController(presentedViewController: presented, presentingViewController: presenting)
        return pController
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = KSAnimatedTransitioning()
        animationController.isPresentation = true
        animationController.animationType = self.animationType
        animationController.transitionDuration = self.transitionDuration
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = KSAnimatedTransitioning()
        animationController.isPresentation = false
        animationController.animationType = self.animationType
        animationController.transitionDuration = self.transitionDuration
        return animationController
    }
    
}
