//
//  listBorrowingCardStudentViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class listBorrowingCardStudentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = temp.value(forKey: "count") as! Int
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell:listBorrowingCardsStudentTableViewCell = listBorrowingCardTableView.dequeueReusableCell(withIdentifier: "listBorrowingCardsStudentTableViewCell") as! listBorrowingCardsStudentTableViewCell
        let data:Array<Dictionary<String,Any>> = self.temp.value(forKey: "data") as! Array<Dictionary<String, Any>>
        let listID:Array<String> = self.temp.value(forKey: "listID") as! Array<String>
        
        cell.bookNameLabel.text = data[indexPath.row]["bookName"] as! String
        cell.startedDayLabel.text = data[indexPath.row]["startedDay"] as! String
        cell.endedDayLabel.text = data[indexPath.row]["endedDay"] as! String
        if (data[indexPath.row]["status"] as! String == "0"){
            cell.statusLabel.text = "Done"
        } else {
            cell.statusLabel.text = ""
            self.addButton.isHidden = true
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listID:Array<String> = self.temp.value(forKey: "listID") as! Array<String>
        self.temp.set(listID[indexPath.row], forKey: "ID_current_bc")
    }
    
    //---Outlet
    @IBOutlet weak var listBorrowingCardTableView: UITableView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    //---Variable
    var temp = UserDefaults()
    //---Action
    
    @IBAction func unwindToBorrowCard(segue:UIStoryboardSegue){
    }
    
    @IBAction func addButton(_ sender: Any) {
    }
    @IBAction func unwindToManageCard(segue:UIStoryboardSegue){
        listBorrowingCardTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listBorrowingCardTableView.dataSource = self
        listBorrowingCardTableView.delegate = self
        listBorrowingCardTableView.reloadData()
        
        // Do any additional setup after loading the view.
        
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student")!)") as! Dictionary<String, Any>
        studentNameLabel.text = t["name"] as? String
        if (t["status"] as! String == "0"){
            addButton.isHidden = true
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.listBorrowingCardTableView.reloadData()
        print("Loaded")
        print(temp.value(forKey: "ID_cards")!)
    }

}
