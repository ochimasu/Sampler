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

        func name() -> String {
            switch self {
            case .normal: return "normal"
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
            animationSegment.removeAllSegments()
            let type = AnimationType.normal
            animationSegment.insertSegment(withTitle: type.name(), at: type.rawValue, animated: false)

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
        case .normal:
            normalShow()
        }
    }

    private func hideAnimation() {
        guard !hiddenStatus else { return }
        hiddenStatus = true

        switch AnimationType(rawValue: animationSegment.selectedSegmentIndex)! {
        case .normal:
            normalHide()
        }
    }

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
                self.targetButton.isHidden = true
            }
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
