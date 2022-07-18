//
//  AddTargetVC.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 16.07.2022.
//

import UIKit

class AddTargetVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtTargetDescription: UITextView!
    
    @IBOutlet weak var btnKisaVadeli: UIButton!
    @IBOutlet weak var btnOrtaVadeli: UIButton!
    @IBOutlet weak var btnUzunVadeli: UIButton!
    @IBOutlet weak var btnİleri: UIButton!
    var targetType : TargetTypes = .KısaVadeli
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtTargetDescription.delegate = self
        btnKisaVadeli.selectedButtonBackgroundColor()
        btnOrtaVadeli.unselectedButtonBackgroundColor()
        btnUzunVadeli.unselectedButtonBackgroundColor()
        btnKisaVadeli.layer.cornerRadius = 7
        btnOrtaVadeli.layer.cornerRadius = 7
        btnUzunVadeli.layer.cornerRadius = 7
        btnİleri.keyboardCarry()
    }
   
    @IBAction func btnKisaVadeliClicked(_ sender: UIButton) {
        
        targetType = .KısaVadeli
        btnKisaVadeli.selectedButtonBackgroundColor()
        btnOrtaVadeli.unselectedButtonBackgroundColor()
        btnUzunVadeli.unselectedButtonBackgroundColor()
    }
    
    @IBAction func btnOrtaVadeliClicked(_ sender: UIButton) {
        
        targetType = .OrtaVadeli
        btnOrtaVadeli.selectedButtonBackgroundColor()
        btnKisaVadeli.unselectedButtonBackgroundColor()
        btnUzunVadeli.unselectedButtonBackgroundColor()
    }
    
    @IBAction func btnUzunVadeli(_ sender: UIButton) {
        
        targetType = .UzunVadeli
        btnUzunVadeli.selectedButtonBackgroundColor()
        btnKisaVadeli.unselectedButtonBackgroundColor()
        btnOrtaVadeli.unselectedButtonBackgroundColor()
    }
    
    @IBAction func btnİleriClicked(_ sender: UIButton) {
        
        if txtTargetDescription.text != "" && txtTargetDescription.text != "Gerçekleştirmek istediğin hedefi girebilirsin." {
            guard let createTargetVC = storyboard?.instantiateViewController(withIdentifier: "CreateTargetVC") as? CreateTargetVC else {
                return
            }
            
            createTargetVC.dataAssignment(description: txtTargetDescription.text, type: targetType)
            presentingViewController?.newPresented(createTargetVC)
        }
    }
    
    @IBAction func btnGeriClicked(_ sender: UIButton) {
        newDismiss()
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        txtTargetDescription.text = ""
        txtTargetDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
