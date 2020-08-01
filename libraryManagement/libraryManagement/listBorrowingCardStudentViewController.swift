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
        let ID_cards:Array<String> = temp.value(forKey: "ID_cards")! as! Array<String>
        print(ID_cards.count)
        return ID_cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ID_cards:Array<String> = temp.value(forKey: "ID_cards")! as! Array<String>
        print(ID_cards.count)
        let cell:listBorrowingCardsStudentTableViewCell = listBorrowingCardTableView.dequeueReusableCell(withIdentifier: "listBorrowingCardsStudentTableViewCell") as! listBorrowingCardsStudentTableViewCell
        if (ID_cards.count != 0){
            let db = Firestore.firestore()
            db.collection("Students").document("\(ID_cards[indexPath.row])")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                print("\(source) data: \(document.data() ?? [:])")
                cell.bookNameLabel.text = document.data()!["ID_book"] as? String
                cell.startedDayLabel.text = document.data()!["startedDay"] as? String
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
        let newCard = BorrowCard()
                let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("BorrowCard").addDocument(data: [
            "ID_student":"\(newCard.ID_student)",
            "ID_book":"\(newCard.ID_book)",
            "startedDay":"\(newCard.endedDay)",
            "endedDay":"",
            "status":"\(newCard.status)",
            "fine":"\(newCard.fine)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.temp.set("\(ref!.documentID)", forKey: "ID_new_card")
            }
        }
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
