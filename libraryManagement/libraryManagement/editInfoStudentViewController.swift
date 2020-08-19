//
//  editInfoStudentViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class editInfoStudentViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return list.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextField.text = self.list[row]
    }
    
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var starteddayTextField: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    var list = ["Male","Female","Other"]
    //---Action
    @IBAction func genderAction(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let picker = UIPickerView(frame: CGRect(x: 30, y:-20, width: 300, height: 400))
        picker.dataSource=self
        picker.delegate=self
        picker.sizeToFit()
        alert.view.addSubview(picker)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            self.genderTextField.text=""
        }
        alert.addAction(cancelButton)
        
        present(alert,animated: true,completion: nil)
    }
    
    

    @IBAction func birthdayAction(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
               let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
               datePicker.sizeToFit()
               datePicker.datePickerMode = .date
               alert.view.addSubview(datePicker)
               let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                   self.birthdayTextField.text = datePicker.date.dateToString()
               }
               alert.addAction(okButton)
               let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
               alert.addAction(cancelButton)
               //        alert.show()
               self.present(alert,animated:true,completion: nil)
    }
    
    @IBAction func startedDayAction(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
              let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
              datePicker.sizeToFit()
              datePicker.datePickerMode = .date
              alert.view.addSubview(datePicker)
              let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                  self.starteddayTextField.text = datePicker.date.dateToString()
              }
              alert.addAction(okButton)
              let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
              alert.addAction(cancelButton)
              //        alert.show()
              self.present(alert,animated:true,completion: nil)
    }
    
    
    @IBAction func confirmAction(_ sender: Any) {
        let currentStudent:Student =  Student(name: nameTextField.text!, ID: idTextField.text!, birthday: birthdayTextField.text!,gender:genderTextField.text!, address: addressTextField.text!, email: emailTextField.text!, startedDay: starteddayTextField.text!, status: 1 )
        if (statusSwitch.isOn){
            currentStudent.status = 1
        } else {
            currentStudent.status = 0
        }

        currentStudent.updateDetail( ID: temp.value(forKey: "ID_current_student")! as! String)
        let alert:UIAlertController = UIAlertController(title: "Notice", message: "Update successfully", preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "unwindToManageStudent", sender: self)
        }
        alert.addAction(okButton)
        present(alert,animated: true,completion: nil)
    }
    
    
    @IBAction func statusSwitch(_ sender: Any) {
        if (statusSwitch.isOn){
            statusLabel.text = "Active"
        }
        else {
            statusLabel.text = "Deact"
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToManageStudent", sender: self)
    }
    //---Function
    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student")!)") as! Dictionary<String, Any>

        nameTextField.text = t["name"] as? String
        birthdayTextField.text = t["birthday"] as? String
        genderTextField.text = t["gender"] as? String
        idTextField.text = t["ID"] as? String
        addressTextField.text = t["address"] as? String
        emailTextField.text = t["email"] as? String
        starteddayTextField.text = t["startedDay"] as? String
        if (t["status"] as! String == "1"){
            statusSwitch.isOn = true
            statusLabel.text="Active"
        } else {
            statusSwitch.isOn = false
            statusLabel.text = "Deact"
        }
        
        idTextField.isEnabled = false
        
        // Do any additional setup after loading the view.
        db.collection("BorrowCard")
        .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            let documents = querySnapshot!.documents
            var count = 0
            for document in documents {
                if (document.data()["ID_student"] as! String == self.idTextField.text!){
                    count += 1
                }
            }
            print(count)
            self.temp.set(count, forKey: "count")
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
