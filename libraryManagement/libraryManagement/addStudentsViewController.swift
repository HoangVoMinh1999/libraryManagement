//
//  addStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addStudentsViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var starteddayTextField: UITextField!
    //---Variable

    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        let students = ref.child("students")
        let detail_student = students.child("detail")
        let detail = detail_student.childByAutoId()
        
        let new_student:Student =  Student(name: nameTextField.text!, ID: IDTextField.text!, birthday: birthdayTextField.text!, address: addressTextField.text!, email: emailTextField.text!, startedDay: starteddayTextField.text!, status: true)
        detail.setValue(new_student)
        let src = (storyboard?.instantiateViewController(identifier: "manageStudentsViewController"))! as addStudentsViewController
        present(src, animated: true,completion: nil)
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        let src = (storyboard?.instantiateViewController(identifier: "manageStudentsViewController"))! as addStudentsViewController
        present(src, animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
