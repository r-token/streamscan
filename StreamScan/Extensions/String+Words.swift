//
//  String+Words.swift
//  Streamr
//
//  Created by Ryan Token on 5/17/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import Foundation

extension StringProtocol {
    var words: [SubSequence] {
        return split{ !$0.isLetter }
    }
}
