//
//  editInfoStudentViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class editInfoStudentViewController: UIViewController {
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
    //---Action
    @IBAction func statusSwitch(_ sender: Any) {
        if (statusSwitch.isOn){
            statusLabel.text = "Active"
        }
        else {
            statusLabel.text = "Deact"
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        let src = (storyboard?.instantiateViewController(identifier: "manageStudentsViewController"))! as manageStudentsViewController
        present(src, animated: true,completion: nil)
        
    }
    //---Function
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = "Vo Minh Hoang"
        birthdayTextField.text = "11-04-1999"
        genderTextField.text = "Male"
        idTextField.text = "1712041"
        addressTextField.text = "TP.HCM"
        emailTextField.text = "hoang@gmail.com"
        statusSwitch.isOn = true
        
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
