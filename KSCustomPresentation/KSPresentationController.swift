//
//  KSPresentationController.swift
//  KSModalController
//
//  Created by Kumar Saurabh on 18/12/15.
//  Copyright © 2015 Kumar Saurabh. All rights reserved.
//

import UIKit

class KSPresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {

    var backgroundView:UIView = UIView()   //bckgnd of presented view controller
    var displacement:CGFloat?   // %age of the screen presented view covers
    var isHorizontalTransition: Bool = false
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        backgroundView.alpha = 0.0
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView?.bounds
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds!.size)
        if(self.isHorizontalTransition) {
            presentedViewFrame.origin.x = (containerBounds?.size.width)! - presentedViewFrame.width
        }else {
            presentedViewFrame.origin.y = (containerBounds?.size.height)! - presentedViewFrame.height
        }
        
        return presentedViewFrame
     }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if(self.isHorizontalTransition) {
            return CGSizeMake((CGFloat(floorf(Float(parentSize.width*self.displacement!)))), parentSize.height)
        }else {
            return CGSizeMake(parentSize.width, (CGFloat(floorf(Float(parentSize.height*self.displacement!)))))
        }
    }
    
    override func presentationTransitionWillBegin() {
        backgroundView.frame = (self.containerView?.bounds)!
        backgroundView.alpha = 0.0
        containerView?.addSubview(backgroundView)
        let coordinator = presentedViewController.transitionCoordinator()
        if(coordinator != nil) {
            coordinator?.animateAlongsideTransition(
                {
                    (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                    self.backgroundView.alpha = 1.0
                }, completion: nil)
        }else {
            backgroundView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentedViewController.transitionCoordinator()
        if(coordinator != nil) {
            coordinator?.animateAlongsideTransition(
                {
                    (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                    self.backgroundView.alpha = 0.0
                }, completion: nil)
        }else {
            self.backgroundView.alpha = 0.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        backgroundView.frame = containerView!.bounds
        presentedView()!.frame = frameOfPresentedViewInContainerView()
    }
    
//    override func shouldPresentInFullscreen() -> Bool {
//        return true
//    }
    
    override func adaptivePresentationStyle() -> UIModalPresentationStyle {
        return .None
    }
    
    //MARK: - Methods to dismiss presented view controller by swipe gesture or by tapping outside of the presented view
    
    func enableTapOutsideToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KSPresentationController.tapGestureRecognised(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func enableRightSwipeToDismiss() {
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(KSPresentationController.rightSwipped(_:)))
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        presentedViewController.view.addGestureRecognizer(rightSwipeGesture)
    }
    
    func enableDownSwipeToDismiss() {
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(KSPresentationController.downSwipped(_:)))
        downSwipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        presentedViewController.view.addGestureRecognizer(downSwipeGesture)
    }
    
    func rightSwipped(swipeGesture:UISwipeGestureRecognizer) {
        if(swipeGesture.direction == UISwipeGestureRecognizerDirection.Right) {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func downSwipped(swipeGesture:UISwipeGestureRecognizer) {
        if(swipeGesture.direction == UISwipeGestureRecognizerDirection.Down) {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func tapGestureRecognised(gesture:UITapGestureRecognizer) {
        if(gesture.state == UIGestureRecognizerState.Ended) {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
