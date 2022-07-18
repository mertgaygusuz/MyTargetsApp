//
//  TargetsListVC.swift
//  MyTargetsApp
//
//  Created by Mert Gaygusuz on 16.07.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class TargetsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var setOfTargets : [Target] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        
        self.fetchData { (complete) in
            if complete {
                
                if setOfTargets.count >= 1 {
                    //Gösterilecek en az bir veri varsa tableView'i görünür yap
                    tableView.isHidden  = false
                } else {
                    //gösterilecek hiçbir veri yoksa tableView görünmez olsun
                    tableView.isHidden = true
                }
                
            }
            
        }
        tableView.reloadData()
    }

    @IBAction func btnAddClicked(_ sender: UIButton) {
        
        guard let addTargetVC = storyboard?.instantiateViewController(withIdentifier: "AddTargetVC") else {
            return
        }
        newPresent(addTargetVC)
    }
    
}

extension TargetsListVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return setOfTargets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "targetCell") as? TargetCell else {
            return UITableViewCell()
        }
        
        let destinationToShow = setOfTargets[indexPath.row]
        
        cell.setView(target: destinationToShow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletionProcess = UITableViewRowAction(style: .destructive, title: "Hedefi Sil") { (action, indexPath) in
            
            self.deleteData(indexPath: indexPath)
            self.loadData()
        }
        deletionProcess.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        let addingProcess = UITableViewRowAction(style: .normal, title: "1 Ekle") { (action, indexPath) in
            
            self.targetDevelopment(indexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addingProcess.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return [deletionProcess,addingProcess]
    }
}


extension TargetsListVC {
    
    func targetDevelopment(indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let selectedTarget = setOfTargets[indexPath.row]
        
        if selectedTarget.targetValidNumber < selectedTarget.numberOfTargetCompletions {
            
            selectedTarget.targetValidNumber += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Hedef ilerlemesi başarıyla güncellendi")
        } catch {
            debugPrint("İlerleme güncellenirken bir hata meydana geldi: \(error.localizedDescription)")
        }
    }
    
    func deleteData(indexPath : IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(setOfTargets[indexPath.row])
        
        do {
            try managedContext.save()
            self.setOfTargets.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            print("Veri başarıyla silindi")
            
        } catch {
            debugPrint("Veri silinirken hata meydana geldi: \(error.localizedDescription)")
        }
    }
    
    func fetchData(completionHandler: (_ complete: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Target>(entityName: "Target")
        
        do {
            
            setOfTargets = try managedContext.fetch(fetchRequest)
            print("Verileri getirme işlemi başarıyla tamamlandı")
            completionHandler(true)
        } catch {
            debugPrint("Verileri çekerken hata meydana geldi \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}
