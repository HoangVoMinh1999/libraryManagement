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
        let picker = UIPickerView(frame: CGRect(x: 30, y:0, width: 300, height: 400))
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
        
        let db = Firestore.firestore()
        // Update one field, creating the document if it does not exist.
        if (statusSwitch.isOn){
            db.collection("Students").document("\(temp.value(forKey: "ID")!)").setData([ "name": nameTextField.text!, "ID": idTextField.text!, "birthday": birthdayTextField.text!,"gender":genderTextField.text!, "address": addressTextField.text!, "email": emailTextField.text!, "startedDay": starteddayTextField.text!, "status": true ], merge: true)
        } else {
            db.collection("Students").document("\(temp.value(forKey: "ID")!)").setData([ "name": nameTextField.text!, "ID": idTextField.text!, "birthday": birthdayTextField.text!,"gender":genderTextField.text!, "address": addressTextField.text!, "email": emailTextField.text!, "startedDay": starteddayTextField.text!, "status": false ], merge: true)
        }
        
        let src = (storyboard?.instantiateViewController(identifier: "studentMenuViewController"))! as studentMenuViewController
        present(src, animated: true,completion: nil)
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
        let src = (storyboard?.instantiateViewController(identifier: "studentMenuViewController"))! as studentMenuViewController
        present(src, animated: true,completion: nil)
        
    }
    //---Function
    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "student") as! Dictionary<String, Any>
        let new_student:Student =  Student(name: t["name"] as! String, ID: t["ID"] as! String, birthday: t["birthday"] as! String,gender: t["gender"] as! String ,address: t["address"] as! String, email: t["email"] as! String, startedDay: t["startedDay"] as! String, status: (t["status"] != nil))
        nameTextField.text = new_student.name
        birthdayTextField.text = new_student.birthday
        genderTextField.text = new_student.gender
        idTextField.text = new_student.ID
        addressTextField.text = new_student.address
        emailTextField.text = new_student.email
        starteddayTextField.text = new_student.startedDay
        if (new_student.status == true){
            statusSwitch.isOn = true
        } else {
            statusSwitch.isOn = false
        }
        
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
