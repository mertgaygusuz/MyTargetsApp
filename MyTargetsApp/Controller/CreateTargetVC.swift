//
//  CreateTargetVC.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 17.07.2022.
//

import UIKit

class CreateTargetVC: UIViewController {
    
    
    @IBOutlet weak var btnHedefiOlustur: UIButton!
    @IBOutlet weak var txtNumberOfTargets: UITextField!
    var targetDescription : String!
    var targetType : TargetTypes!
    
    func dataAssignment(description : String, type : TargetTypes) {
        
        self.targetDescription = description
        self.targetType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnHedefiOlustur.keyboardCarry()
    }
    

    @IBAction func btnHedefiOlusturClicked(_ sender: Any) {
        
        if txtNumberOfTargets.text != "" {
            if Int(txtNumberOfTargets.text!)! > 0 {
                
                self.save { (finish) in
                    if finish {
                        dismiss(animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    
    func save(completionHandler: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let target = Target(context: managedContext)
        target.targetDescription = targetDescription
        target.targetType = targetType.rawValue
        target.numberOfTargetCompletions = Int32(txtNumberOfTargets.text!)!
        target.targetValidNumber = Int32(0)
        
        do {
            try managedContext.save()
            print("Veriler başarıyla kaydedildi")
            completionHandler(true)
        } catch {
            debugPrint("Kayıt işlemi başarısız: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        newDismiss()
    }
    
    
}
