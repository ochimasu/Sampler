//
//  ShowHideAnimationViewController.swift
//  Samplers
//
//  Created by Toshiyuki M on 2018/04/21.
//  Copyright © 2018年 ochimasu. All rights reserved.
//

import UIKit

class ShowHideAnimationViewController: UIViewController {
    @IBOutlet private weak var label: UILabel!

    @IBAction private func showTapped(_ sender: UIButton) {
        label.isHidden = false
    }
    @IBAction private func hideTapped(_ sender: UIButton) {
        label.isHidden = true
    }
}
