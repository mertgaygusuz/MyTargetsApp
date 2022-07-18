//
//  TargetCell.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 16.07.2022.
//

import UIKit

class TargetCell: UITableViewCell {

   
    @IBOutlet weak var lblTargetDescription: UILabel!
    @IBOutlet weak var lblTargetType: UILabel!
    @IBOutlet weak var lblNumberOfTarget: UILabel!
    @IBOutlet weak var completedView: UIView!
    
    
    
    func setView(target: Target) {
        lblTargetDescription.text = target.targetDescription
        lblTargetType.text = target.targetType
        lblNumberOfTarget.text = String(target.targetValidNumber)
        
        if target.targetValidNumber == target.numberOfTargetCompletions {
            
            completedView.isHidden = false
        }
        else {
            completedView.isHidden = true
        }
    }
}
