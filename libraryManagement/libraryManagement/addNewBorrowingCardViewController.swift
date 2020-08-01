//
//  addNewBorrowingCardViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 7/16/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addNewBorrowingCardViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idStudentTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var idBookTextField: UITextField!
    @IBOutlet weak var startedDayTextField: UITextField!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    //---Action
    @IBAction func bookIDAction(_ sender: Any) {
        let amount = 0
        if (amount != 0){
            noticeLabel.isHidden = false
            noticeLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 0.1, green: 1, blue: 0.5, alpha: 1))
            noticeLabel.text = "* This book is available to borrow"
        } else {
            noticeLabel.isHidden = false
            noticeLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 1, green: 0.1, blue: 0.5, alpha: 1))
            noticeLabel.text = "* No available book in library"
        }

    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let ID_new_card = temp.value(forKey: "ID_new_card") as! String
        
        let db = Firestore.firestore()
        let currentCard = db.collection("BorrowCard").document(ID_new_card)

        // Set the "capital" field of the city 'DC'
        currentCard.updateData([
            "ID_student":"\(idStudentTextField.text!)",
            "ID_book":"\(idBookTextField.text!)",
            "startedDay":"\(startedDayTextField.text!)",
            "endedDay":"",
            "status":"1",
            "fine":""
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "student") as! Dictionary<String, Any>
        nameTextField.isEnabled = false
        idStudentTextField.isEnabled = false
        nameTextField.text = t["name"] as? String
        idStudentTextField.text = t["ID"] as? String
        
        noticeLabel.isHidden = true
        
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
