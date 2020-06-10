//
//  manageStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class manageStudentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:listStudentsTableViewCell = listStudentsTable.dequeueReusableCell(withIdentifier: "listStudentsTableViewCell") as! listStudentsTableViewCell
        cell.studentNameLabel.text = list[indexPath.row]
        cell.MSSVLabel.text = MSSV[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to delete this student?", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.list.remove(at: indexPath.row)
                self.MSSV.remove(at: indexPath.row)
                
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
    var list:[String] = ["Vo Minh Hoang","Ha Cao Duy","VM Hoang"]
    var MSSV:[String] = ["1712041","1712016","69"]
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
