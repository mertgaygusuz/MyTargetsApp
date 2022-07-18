//
//  UIViewControllerExtension.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 16.07.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func newPresent(_ viewControllerToPresent : UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: "presentAnimation")
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func newPresented(_ viewControllerToPresent : UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromRight
        guard let presentedVC = presentedViewController else { return }
        presentedVC.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: "presentedAnimation")
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
    }
    
    func newDismiss() {
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition,forKey: "dismissAnimation")
        dismiss(animated: false, completion: nil)
    }
}
