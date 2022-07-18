//
//  UIViewExtension.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 17.07.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func keyboardCarry() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardReplacement(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardReplacement(_ notification : NSNotification) {
        
        //time to change keyboard position
        let sure = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let differenceY = endKeyboardFrame.origin.y - startKeyboardFrame.origin.y
        
        UIView.animateKeyframes(withDuration: sure, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve) ,animations: {
            self.frame.origin.y += differenceY
        }, completion: nil)
    }
}
