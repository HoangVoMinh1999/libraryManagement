//
//  ruleViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 31/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

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
        let ID_rules:Array<String> = tmp.value(forKey: "ID_rules") as! Array<String>
        return ID_rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID_rules:Array<String> = tmp.value(forKey: "ID_rules") as! Array<String>
        let cell: listRulesTableViewCell = rulesTableView.dequeueReusableCell(withIdentifier: "listRulesTableViewCell") as! listRulesTableViewCell
        let db = Firestore.firestore()
        db.collection("Rules").document("\(ID_rules[indexPath.row])")
        .addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            cell.ruletitleLabel.text = document.data()!["title"]! as? String
            cell.rulecontentLabel.text = document.data()!["content"]! as? String
            self.tmp.set(document.data(), forKey: "\(ID_rules[indexPath.row])")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ID_rules:Array<String> = tmp.value(forKey: "ID_rules") as! Array<String>
        self.tmp.setValue(ID_rules[indexPath.row], forKey: "ID_current_rule")
        }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to delete this rule?", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    
                self.rulesTableView.deleteRows(at: [indexPath], with: .fade)
            }
            alert.addAction(okButton)
            let cancelButton:UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
                alert.addAction(cancelButton)
                present(alert, animated: false,completion: nil)
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
