//
//  UIViewExt.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 18/11/2023.
//

import UIKit

extension UIView {
    
    func cornerRadius () {
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    func capsuleCornerRadius() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}


