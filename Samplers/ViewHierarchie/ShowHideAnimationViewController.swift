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

        hiddenStatus = label.isHidden
    }

    // MARK: - private

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    private var hiddenStatus: Bool = false {
        didSet {
            statusLabel.text = hiddenStatus ? "hidden" : "show"
        }
    }

    // MARK: - Actions

    private func showAnimation() {
        hiddenStatus = false

        label.isHidden = false

        UIView.animate(withDuration: 1, animations: {
            self.label.alpha = 1
        }, completion: nil)
    }

    private func hideAnimation() {
        hiddenStatus = true

        UIView.animate(withDuration: 1, animations: {
            self.label.alpha = 0
        }) { (finished) in
            print(finished)
            self.label.isHidden = true
        }
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
