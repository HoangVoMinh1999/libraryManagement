//
//  editBorrowCardViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 8/19/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class editBorrowCardViewController: UIViewController {
    //---Variable
    var temp = UserDefaults()
    //---Outlet
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var bookIDTextField: UITextField!
    @IBOutlet weak var startedDayTextField: UITextField!
    @IBOutlet weak var endedDayTextField: UITextField!
    @IBOutlet weak var fineTextField: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    //---Action
    
    @IBAction func statusAction(_ sender: Any) {
        if (statusSwitch.isOn == false){
            let date = Date()
            endedDayTextField.text = date.dateToString()
            
        } else {
            endedDayTextField.text = ""
        }
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        let ID:String = temp.value(forKey: "ID_current_bc") as! String
        // Update one field, creating the document if it does not exist.
        if (statusSwitch.isOn == false){
            db.collection("BorrowCard").document(ID).setData([ "endedDay": "\(endedDayTextField.text!)","status":"0" ], merge: true)
            db.collection("Books").document("\(bookIDTextField.text!)").setData([ "check": temp.value(forKey: "check") as! Int - 1 ], merge: true)
        } else {
        db.collection("cities").document(ID).setData([ "endedDay": "\(endedDayTextField.text!)" ], merge: true)
        }
        let alert:UIAlertController = UIAlertController(title: "Notice", message: "Update successfully !!!", preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "unwindToBorrowCardWithSegue", sender: self)
        }
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToBorrowCardWithSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let student:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student") as! String)") as! Dictionary<String, Any>
        
        let bc:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_bc") as! String)") as! Dictionary<String, Any>
        
        studentNameTextField.text = student["name"] as! String
        studentIDTextField.text = bc["ID_student"] as! String
        bookIDTextField.text = bc["ID_book"] as! String
        startedDayTextField.text = bc["startedDay"] as! String
        endedDayTextField.text = bc["endedDay"] as! String
        fineTextField.text = bc["fine"] as! String
        
        if (bc["status"] as! String == "1"){
            statusSwitch.isOn = true
        } else {
            statusSwitch.isOn = false
        }
            
        // Do any additional setup after loading the view.
        studentIDTextField.isEnabled = false
        studentNameTextField.isEnabled = false
        bookIDTextField.isEnabled = false
        startedDayTextField.isEnabled = false
        endedDayTextField.isEnabled = false
        fineTextField.isEnabled = false
        
        let docRef = db.collection("Books").document("\(bookIDTextField.text!)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.temp.set(document.data()!["check"], forKey: "check")
            } else {
                print("Document does not exist")
            }
        }
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
