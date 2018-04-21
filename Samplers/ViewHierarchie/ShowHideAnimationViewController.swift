//
//  ShowHideAnimationViewController.swift
//  Samplers
//
//  Created by Toshiyuki M on 2018/04/21.
//  Copyright © 2018年 ochimasu. All rights reserved.
//

import UIKit

class ShowHideAnimationViewController: UIViewController {

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hiddenStatus = targetButton.isHidden
    }

    // MARK: - private

    @IBOutlet private weak var targetButton: UIButton!
    @IBOutlet private weak var statusLabel: UILabel!

    private var hiddenStatus: Bool = false {
        didSet {
            statusLabel.text = hiddenStatus ? "hidden" : "show"
        }
    }

    // MARK: - Actions

    private func showAnimation() {
        hiddenStatus = false

        targetButton.isHidden = false

        UIView.animate(withDuration: 1, animations: {
            self.targetButton.alpha = 1
        }, completion: nil)
    }

    private func hideAnimation() {
        hiddenStatus = true

        UIView.animate(withDuration: 1, animations: {
            self.targetButton.alpha = 0
        }) { (finished) in
            print(finished)
            self.targetButton.setHiddenMatchAlpha()
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
