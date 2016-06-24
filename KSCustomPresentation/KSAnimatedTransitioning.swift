//
//  KSAnimatedTransitioning.swift
//  KSModalController
//
//  Created by Kumar Saurabh on 18/12/15.
//  Copyright © 2015 Kumar Saurabh. All rights reserved.
//

import UIKit

enum AnimationType: String {
    case rightCenterRightAnimation = "RightCenterRightAnimation", bottomCenterBottomAnimation = "BottomCenterBottomAnimation"
}

class KSAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation: Bool = false
    var animationType: String?
    var transitionDuration: CGFloat?
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch(animationType!) {
            case AnimationType.rightCenterRightAnimation.rawValue:
                self.rightCenterRightAnimation(transitionContext)
            
            case AnimationType.bottomCenterBottomAnimation.rawValue:
                self.bottomCenterBottomAnimation(transitionContext)
            
            default:
                self.rightCenterRightAnimation(transitionContext)
        }
    }
    
    func bottomCenterBottomAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let fromView = fromVC?.view
        let toView = toVC?.view
        let containerView = transitionContext.containerView()

        let animatingVC = isPresentation ? toVC : fromVC
        let presentingVC = isPresentation ? fromVC : toVC
        let animatingView = animatingVC?.view
        let presentingView = presentingVC?.view
        
        if isPresentation {
            containerView!.addSubview(toView!)
        }
        
        let finalFrameForVC = transitionContext.finalFrameForViewController(animatingVC!)
        var initialFrameForVC = finalFrameForVC
        initialFrameForVC.origin.y += initialFrameForVC.size.height;
        
        var presentingVCFinalFrame = presentingView!.frame
        presentingVCFinalFrame.origin.y = isPresentation ? -initialFrameForVC.size.height : 0.0
        
        let initialFrame = isPresentation ? initialFrameForVC : finalFrameForVC
        let finalFrame = isPresentation ? finalFrameForVC : initialFrameForVC
        
        animatingView?.frame = initialFrame
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay:0, usingSpringWithDamping:300.0, initialSpringVelocity:5.0, options:UIViewAnimationOptions.AllowUserInteraction, animations:{
            
            animatingView?.frame = finalFrame
            
//            if presenting controller also needs to be moved, uncomment next line
//            presentingView?.frame = presentingVCFinalFrame
            
            }, completion:{ (value: Bool) in
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
        })
    }
    
    func rightCenterRightAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromView = fromVC?.view
        let toView = toVC?.view
        let containerView = transitionContext.containerView()
        
        if isPresentation {
            containerView!.addSubview(toView!)
        }
        
        let animatingVC = isPresentation ? toVC : fromVC
        let presentingVC = isPresentation ? fromVC : toVC
        let animatingView = animatingVC?.view
        let presentingView = presentingVC?.view
        
        let finalFrameForVC = transitionContext.finalFrameForViewController(animatingVC!)
        var initialFrameForVC = finalFrameForVC
        initialFrameForVC.origin.x += initialFrameForVC.size.width;
        
        var presentingVCFinalFrame = presentingView!.frame
        presentingVCFinalFrame.origin.x = isPresentation ? -initialFrameForVC.size.width : 0.0
        
        let initialFrame = isPresentation ? initialFrameForVC : finalFrameForVC
        let finalFrame = isPresentation ? finalFrameForVC : initialFrameForVC
        
        animatingView?.frame = initialFrame
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay:0, usingSpringWithDamping:300.0, initialSpringVelocity:5.0, options:UIViewAnimationOptions.AllowUserInteraction, animations:{
            
            animatingView?.frame = finalFrame
            
//            if presenting controller also needs to be moved, uncomment next line
//            presentingView?.frame = presentingVCFinalFrame
            
            }, completion:{ (value: Bool) in
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        let time = NSTimeInterval(transitionDuration!)
        return time
    }
}
