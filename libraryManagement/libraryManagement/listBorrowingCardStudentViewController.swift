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
                }
            }
        }
        return cell
    }
    
    //---Outlet
    @IBOutlet weak var listBorrowingCardTableView: UITableView!
    @IBOutlet weak var studentNameLabel: UILabel!
    //---Variable
    var temp = UserDefaults()
    //---Action
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
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.listBorrowingCardTableView.reloadData()
        print("Loaded")
        print(temp.value(forKey: "ID_cards")!)
    }

}
