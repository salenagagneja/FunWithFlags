//
//  FWFPopupViewController.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import UIKit

private enum ModalTransitionType {
    case presentation, dismissal
}

class FWFPopupViewController: UIViewController {

    // MARK: Stored Properties
    var containerView: UIView!
    var shouldDismissOnSwipeDown: Bool = true
    var shouldDismissOnTapOutside: Bool = true
    private var currentModalTransitionType: ModalTransitionType?
    fileprivate static let overlayBackgroundColor = UIColor.black.withAlphaComponent(0.3)

    // MARK: App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSwipeDownGesture()
        configureTapGesture()
    }

    // MARK: Instance Functions
    private func configureUI() {
        transitioningDelegate = self
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    private func configureSwipeDownGesture() {
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(_:)))
        swipeDownGesture.direction = .down
        view.addGestureRecognizer(swipeDownGesture)
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func didSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        if shouldDismissOnSwipeDown {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        if shouldDismissOnTapOutside {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension FWFPopupViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}

extension FWFPopupViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let result = (presented == self) ? self : nil
        result?.currentModalTransitionType = .presentation
        return result
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let result = (dismissed == self) ? self : nil
        result?.currentModalTransitionType = .dismissal
        return result
    }
}

extension FWFPopupViewController: UIViewControllerAnimatedTransitioning {
    private var transitionDuration: TimeInterval {
        guard let transitionType = self.currentModalTransitionType else { return 0.44 }
        switch transitionType {
        case .presentation:
            return 0.44
        case .dismissal:
            return 0.32
        }
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let transitionType = self.currentModalTransitionType else { return }

        // Here's the state we'd be in when the card is offscreen
        let cardOffscreenState = {
            let offscreenY = self.view.bounds.height - self.containerView.frame.minY + 20
            self.containerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: offscreenY)
            self.view.backgroundColor = .clear
        }

        // ...and here's the state of things when the card is onscreen.
        let presentedState = {
            self.containerView.transform = CGAffineTransform.identity
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }

        // We want different animation timing, based on whether we're presenting or dismissing.
        let animator: UIViewPropertyAnimator
        switch transitionType {
        case .presentation:
            animator = UIViewPropertyAnimator(duration: transitionDuration, dampingRatio: 0.82)
        case .dismissal:
            animator = UIViewPropertyAnimator(duration: transitionDuration, curve: UIView.AnimationCurve.easeIn)
        }

        switch transitionType {
        case .presentation:
            // We need to add the modal to the view hierarchy,
            // and perform the animation.
            let toView = transitionContext.view(forKey: .to)!
            UIView.performWithoutAnimation(cardOffscreenState)
            transitionContext.containerView.addSubview(toView)
            animator.addAnimations(presentedState)
        case .dismissal:
            // The modal is already in the view hierarchy,
            // so we just perform the animation.
            animator.addAnimations(cardOffscreenState)
        }

        // When the animation finishes,
        // we tell the system that the animation has completed,
        // and clear out our transition type.
        animator.addCompletion { (position) in
            assert(position == .end)
            transitionContext.completeTransition(true)
            self.currentModalTransitionType = nil
        }

        // ... and here's where we kick off the animation:
        animator.startAnimation()
    }
}
