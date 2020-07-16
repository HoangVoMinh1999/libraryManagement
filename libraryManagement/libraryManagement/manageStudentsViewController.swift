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
        return temp.value(forKey: "amount_of_students") as! Int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data:Array<Dictionary<String,Any>> = temp.value(forKey: "data_students") as! Array<Dictionary<String, Any>>
        
        let ID:Array<String> = temp.value(forKey: "ID_students") as! Array<String>
        
        let cell:listStudentsTableViewCell = listStudentsTable.dequeueReusableCell(withIdentifier: "listStudentsTableViewCell") as! listStudentsTableViewCell
        cell.studentNameLabel.text = data[indexPath.row]["name"] as? String
        cell.MSSVLabel.text = data[indexPath.row]["ID"] as? String
        temp.set(data[indexPath.row], forKey: "student")
        temp.set(ID[indexPath.row], forKey: "ID")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    @IBOutlet weak var searchNameButton: UIButton!
    @IBOutlet weak var searchIDButton: UIButton!
    @IBOutlet weak var listStudentsTable: UITableView!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    

    //---Action
    @IBAction func searchNameButton(_ sender: UIButton) {
        if (sender.isSelected){
            sender.isSelected = false
            searchIDButton.isSelected = true
        } else {
            sender.isSelected = true
            searchIDButton.isSelected = false
        }
    }
    @IBAction func searchIDButton(_ sender: UIButton) {
        if (sender.isSelected){
            sender.isSelected = false
            searchNameButton.isSelected = true
        } else {
            sender.isSelected = true
            searchNameButton.isSelected = false
        }
    }
    //---Function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNameButton.isSelected = true
        listStudentsTable.dataSource = self
        listStudentsTable.delegate = self
    
        listStudentsTable.reloadData()


        
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
