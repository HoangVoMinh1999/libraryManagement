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
 
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student")!)") as! Dictionary<String, Any>
        
        let cell:listBorrowingCardsStudentTableViewCell = listBorrowingCardTableView.dequeueReusableCell(withIdentifier: "listBorrowingCardsStudentTableViewCell") as! listBorrowingCardsStudentTableViewCell
        let db = Firestore.firestore()
        db.collection("BorrowCard")
        .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            let documents = querySnapshot!.documents
            var ID_bc:Array<String> = []
            for document in documents {
                if (document.data()["ID_student"] as! String == t["ID"] as! String){
                    cell.bookNameLabel.text = document.data()["bookName"] as! String
                    cell.endedDayLabel.text = document.data()["endedDay"] as! String
                    cell.startedDayLabel.text = document.data()["startedDay"] as! String
                    if (document.data()["status"] as! String == "1"){
                        cell.statusLabel.text = ""
                    } else {
                        cell.statusLabel.text = "Done"
                    }
                    ID_bc.append(document.documentID)
                    self.temp.set(document.data(), forKey: "\(document.documentID)")
                }
            }
            self.temp.set(ID_bc, forKey: "listBC")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ID_bc:Array<String> = temp.array(forKey: "listBC") as! Array<String>
        print(ID_bc[indexPath.row])
        self.temp.set(ID_bc[indexPath.row], forKey: "ID_current_bc")
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
