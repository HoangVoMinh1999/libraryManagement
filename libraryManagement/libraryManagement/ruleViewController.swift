//
//  ruleViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 31/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
let db = Firestore.firestore()
class ruleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //---Variable
    var tmp = UserDefaults()
    //---Outlet
    @IBOutlet weak var rulesTableView: UITableView!
    
    //---Action
    @IBAction func unwindToRule(segue:UIStoryboardSegue) {
    }
    
    //---Func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ID_rules:Array<String> = self.tmp.value(forKey: "ID_rules") as! Array<String>
        print("1")
        return ID_rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID_rules:Array<String> = tmp.value(forKey: "ID_rules") as! Array<String>
        let cell: listRulesTableViewCell = rulesTableView.dequeueReusableCell(withIdentifier: "listRulesTableViewCell") as! listRulesTableViewCell
                
        db.collection("Rules")
        .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            let documents = querySnapshot!.documents
            cell.ruletitleLabel.text = documents[indexPath.row]["title"] as! String
            cell.contentTextArea.text = documents[indexPath.row]["content"] as! String
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var ID_rules:Array<String> = tmp.value(forKey: "ID_rules") as! Array<String>
        if editingStyle == .delete {
            self.rulesTableView.deleteRows(at: [indexPath], with: .automatic)
//            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Delete successfully !!!", preferredStyle: .alert)
//            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
//                db.collection("Rules").document("\(ID_rules[indexPath.row])").delete() { err in
//                        if let err = err {
//                            print("Error removing document: \(err)")
//                        } else {
//                            print("Document successfully removed!")
//                        }
//                    }
//                ID_rules.remove(at: indexPath.row)
//                self.tmp.set(ID_rules, forKey: "ID_rules")
//            }
//            alert.addAction(okButton)
//            present(alert, animated: false,completion: nil)
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
        rulesTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
