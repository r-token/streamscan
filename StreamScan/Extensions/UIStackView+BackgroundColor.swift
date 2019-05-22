//
//  UIStackView+BackgroundColor.swift
//  Streamr
//
//  Created by Ryan Token on 5/12/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let screenBounds = UIScreen.main.bounds
        let subView = UIView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 18))
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
