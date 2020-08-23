//
//  editAccountViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 30/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class editAccountViewController: UIViewController {
    //---Variable
    var temp = UserDefaults()
    //---Outlet
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password_1TextField: UITextField!
    @IBOutlet weak var password_2TextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        if (fullnameTextField.text! == "" || birthdayTextField.text! == "" || emailTextField.text! == "" || genderTextField.text! == ""){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill all data", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        } else if (password_1TextField.text! != password_2TextField.text! ){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill all data", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        } else {
            Auth.auth().currentUser?.updatePassword(to: password_1TextField.text!) { (error) in
              // ...
            }
            db.collection("Accounts").document(emailTextField.text!).setData(["name":fullnameTextField.text!,
            "birthday":birthdayTextField.text!,
            "gender":genderTextField.text!,
            "email":emailTextField.text!
             ], merge: true)
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill all data", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.performSegue(withIdentifier: "unwindToAccountViewWithSegue", sender: self)
            }
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {                        self.performSegue(withIdentifier: "unwindToAccountViewWithSegue", sender: self)
        
    }
    
    
    
    //---Variable
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "current_user") as! Dictionary<String, Any>

        fullnameTextField.text = t["name"] as! String
        birthdayTextField.text = t["birthday"] as! String
        genderTextField.text = t["gender"] as! String
        emailTextField.text = t["email"] as! String
        
        emailTextField.isEnabled = false
        password_2TextField.isSecureTextEntry = true
        password_1TextField.isSecureTextEntry = true
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
