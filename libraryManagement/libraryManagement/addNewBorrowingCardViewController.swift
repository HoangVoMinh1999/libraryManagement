//
//  addNewBorrowingCardViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 7/16/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addNewBorrowingCardViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let ID_books:Array<String> = temp.value(forKey: "ID_books") as! Array<String>
        return ID_books.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data:Array<String> = temp.value(forKey: "listBook") as! Array<String>
        print(data)
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data:Array<String> = temp.value(forKey: "listBook") as! Array<String>
        idBookTextField.text = data[row]
    }
    
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idStudentTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var idBookTextField: UITextField!
    @IBOutlet weak var startedDayTextField: UITextField!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    var id = ""
    var name = ""
    //---Action
    
    @IBAction func dateTextField(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
        datePicker.sizeToFit()
        datePicker.datePickerMode = .date
        alert.view.addSubview(datePicker)
        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.startedDayTextField.text = datePicker.date.dateToString()
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        //        alert.show()
        self.present(alert,animated:true,completion: nil)
    }
    
    
    @IBAction func bookAction(_ sender: Any) {
        let data:Array<String> = temp.value(forKey: "listBook") as! Array<String>
        idBookTextField.text = data[0]
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let picker = UIPickerView(frame: CGRect(x: 30, y:0, width: 300, height: 400))
        picker.dataSource=self
        picker.delegate=self
        picker.sizeToFit()
        alert.view.addSubview(picker)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            self.idBookTextField.text = ""
        }
        alert.addAction(cancelButton)
        
        present(alert,animated: true,completion: nil)
    }
    
    
    @IBAction func bookIDAction(_ sender: Any) {
        let data = idBookTextField.text?.components(separatedBy: "-")
        id = data![0]
        name = data![1]
        print (id)
        
        let docRef = db.collection("Books").document("\(self.id)")

          docRef.getDocument { (document, error) in
              if let document = document, document.exists {
                if (Int(document.data()!["quantity"] as! String)! > document.data()!["check"] as! Int){
                          self.noticeLabel.isHidden = false
                          self.noticeLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 0.1, green: 1, blue: 0.5, alpha: 1))
                          self.noticeLabel.text = "* This book is available to borrow"
                        self.temp.set(document.data()!["check"] as! Int, forKey: "check")
                      } else {
                          self.noticeLabel.isHidden = false
                          self.noticeLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 1, green: 0.1, blue: 0.5, alpha: 1))
                          self.noticeLabel.text = "* No available book in library"
                      }
              } else {
                  print("Document does not exist")
              }
          }



    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let new_rule:BorrowCard = BorrowCard(ID_student: idStudentTextField.text!, ID_book: id, bookName: name, startedDay: startedDayTextField.text!, endedDay: "", status: 1, fine: 0)
        
        new_rule.addCard()
        let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add card successfully !!!", preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            // Update one field, creating the document if it does not exist.
            db.collection("Books").document(self.id).setData([ "check": (self.temp.value(forKey: "check") as! Int + 1) ], merge: true)
        }
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student")!)") as! Dictionary<String, Any>
        nameTextField.isEnabled = false
        idStudentTextField.isEnabled = false
        nameTextField.text = t["name"] as? String
        idStudentTextField.text = t["ID"] as? String
        
        noticeLabel.isHidden = true
        
        // Do any additional setup after loading the view.
    }
}

extension UIViewController {
    func loadBook (temp:UserDefaults){
        db.collection("Books")
        .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            var data:Array<String> = []
            let documents = querySnapshot!.documents
            for document in documents {
                let temp: String = "\(document.data()["ID"]!)-\(document.data()["name"]!)"
                data.append(temp)
            }
            temp.set(data, forKey: "listBook")
        }
    }
}
