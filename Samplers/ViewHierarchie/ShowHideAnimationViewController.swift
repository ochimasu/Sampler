//
//  ShowHideAnimationViewController.swift
//  Samplers
//
//  Created by Toshiyuki M on 2018/04/21.
//  Copyright © 2018年 ochimasu. All rights reserved.
//

import UIKit

final class ShowHideAnimationViewController: UIViewController {

    private enum AnimationType: Int {
        case normal = 0
        case scale_keyframe

        func name() -> String {
            switch self {
            case .normal: return "normal"
            case .scale_keyframe: return "scale(keyframe)"
            }
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hiddenStatus = targetButton.isHidden
    }

    // MARK: - private

    @IBOutlet private weak var targetButton: UIButton!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var animationSegment: UISegmentedControl! {
        didSet {
            let types: [AnimationType] = [.normal, .scale_keyframe]

            animationSegment.removeAllSegments()
            types.forEach {
                animationSegment.insertSegment(withTitle: $0.name(), at: $0.rawValue, animated: false)
            }

            animationSegment.selectedSegmentIndex = AnimationType.normal.rawValue
        }
    }

    private var hiddenStatus: Bool = false {
        didSet {
            statusLabel.text = hiddenStatus ? "hidden" : "show"
        }
    }

    // MARK: - Actions

    private func showAnimation() {
        guard hiddenStatus else { return }
        hiddenStatus = false

        switch AnimationType(rawValue: animationSegment.selectedSegmentIndex)! {
        case .normal: normalShow()
        case .scale_keyframe: scaleShow()
        }
    }

    private func hideAnimation() {
        guard !hiddenStatus else { return }
        hiddenStatus = true

        switch AnimationType(rawValue: animationSegment.selectedSegmentIndex)! {
        case .normal: normalHide()
        case .scale_keyframe: scaleHide()
        }
    }

    @IBAction private func targetButtonTapped(_ sender: UIButton) {
        statusLabel.text = "tapped"
    }
    @IBAction private func showTapped(_ sender: UIButton) {
        showAnimation()
    }
    @IBAction private func hideTapped(_ sender: UIButton) {
        hideAnimation()
    }
    @IBAction private func switchTapped(_ sender: UIButton) {
        if hiddenStatus {
            showAnimation()
        } else {
            hideAnimation()
        }
    }
}

// Animations

extension ShowHideAnimationViewController {
    private func normalShow() {
        targetButton.isHidden = false

        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState], animations: {
            self.targetButton.alpha = 1
        }, completion: nil)
    }

    private func normalHide() {
        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState], animations: {
            self.targetButton.alpha = 0
        }) { (finished) in
            if finished {
                // alpha値が 0.01未満ではどのみちタッチイベントは無視されるのであまり関係ない
                self.targetButton.isHidden = true
            }
        }
    }

    private func scaleShow() {
        let targetView = targetButton!
        targetView.isHidden = false

        let lenearAnimation = UIViewKeyframeAnimationOptions(rawValue: UIViewAnimationOptions.curveLinear.rawValue)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.beginFromCurrentState, lenearAnimation], animations: {
            let animationRate: Double = 1/2
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: animationRate, animations: {
                targetView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
                targetView.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: animationRate, relativeDuration: 1, animations: {
                targetView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
        }, completion: nil)
    }

    private func scaleHide() {
        let targetView = targetButton!

        // UIView.animateの completionで繋ぐ場合、[.beginFromCurrentState]が上手く働かず、completionでの finishedも正しく取れない為、animateKeyFrames)()を使う
        // KeyFramesでは、animationCurveの指定は可能だが、全体を通してしか指定出来ない
        let lenearAnimation = UIViewKeyframeAnimationOptions(rawValue: UIViewAnimationOptions.curveLinear.rawValue)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.beginFromCurrentState, lenearAnimation], animations: {
            let animationRate: Double = 1/2
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: animationRate, animations: {
                targetView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            })
            UIView.addKeyframe(withRelativeStartTime: animationRate, relativeDuration: 1, animations: {
                targetView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
                targetView.alpha = 0
            })
        }) { (finished) in
            print(finished)
            if finished {
                // alpha値が 0.01未満ではどにみちタッチイベントは無視されるのであまり関係ない
                self.targetButton.isHidden = true
            }
        }
    }
}
