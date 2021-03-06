//
//  manageStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class manageStudentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ID_students:Array<String> = temp.value(forKey: "ID_students") as! Array<String>
        return ID_students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ID_students:Array<String> = temp.value(forKey: "ID_students") as! Array<String>

        let cell:listStudentsTableViewCell = listStudentsTable.dequeueReusableCell(withIdentifier: "listStudentsTableViewCell") as! listStudentsTableViewCell
        let db = Firestore.firestore()
        db.collection("Students").document("\(ID_students[indexPath.row])")
        .addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            if (document.data()!["name"] as! String != ""){
                cell.MSSVLabel.text = document.data()!["ID"]! as? String
                cell.studentNameLabel.text = document.data()!["name"]! as? String
                self.temp.set(document.data(), forKey: "\(ID_students[indexPath.row])")
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ID_students:Array<String> = temp.value(forKey: "ID_students") as! Array<String>
        self.temp.setValue(ID_students[indexPath.row], forKey: "ID_current_student")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let ID_students:Array<String> = temp.value(forKey: "ID_students") as! Array<String>
        if editingStyle == .delete {
            let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to delete this student?", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                
                self.listStudentsTable.deleteRows(at: [indexPath], with: .fade)
                
            }
            alert.addAction(okButton)
            let cancelButton:UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(cancelButton)
            present(alert, animated: false,completion: nil)
        }
    }
    
    //---Outlet
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listStudentsTable: UITableView!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    

    //---Action
    @IBAction func unwindToManageStudent(segue:UIStoryboardSegue){
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listStudentsTable.dataSource = self
        listStudentsTable.delegate = self
        
        let ID_students:Array<String> = temp.value(forKey: "ID_students") as! Array<String>
        if (ID_students.count != 0){
            noticeLabel.isHidden = true
            addButton.isHidden = true
        } else {
            nameLabel.isHidden = true
            idLabel.isHidden = true
            listStudentsTable.isHidden = true
        }
    
        listStudentsTable.reloadData()
    }
}
