//
//  FirstViewController.swift
//  InvisibleNavBarTest
//
//  Created by Seth Rininger on 7/17/17.
//  Copyright © 2017 Vimvest. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
    }

}

extension FirstViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

extension FirstViewController: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.viewController(forKey: .from)?.childViewControllers.first as? FirstViewController,
            let toVC = transitionContext.viewController(forKey: .to)?.childViewControllers.first as? SecondViewController else { return }
        let containerView = transitionContext.containerView

        containerView.addSubview(toVC.view)
        containerView.bringSubview(toFront: toVC.view)
        let viewOriginY = toVC.view.frame.origin.y
        toVC.view.frame.origin.y = UIScreen.main.bounds.height
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: {
            toVC.view.frame.origin.y = viewOriginY
        }, completion: { _ in

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
