//
//  UIView+Status.swift
//  Samplers
//
//  Created by Toshiyuki M on 2018/04/21.
//  Copyright © 2018年 ochimasu. All rights reserved.
//

import UIKit

extension UIView {
    func setHiddenMatchAlpha() {
        isHidden = alpha.isZero
    }
}
