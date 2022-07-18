//
//  UIButtonExtension.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 17.07.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func unselectedButtonBackgroundColor() {
        
        self.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    func selectedButtonBackgroundColor() {
        
        self.backgroundColor = #colorLiteral(red: 0.006242598873, green: 0.4581466317, blue: 0.8921137452, alpha: 1)
    }
}
