//
//  resetPasswordViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 17/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class resetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        let email = emailTextField.text
        if (email == "")
        {
            let alert:UIAlertController=UIAlertController(title: "Warning", message: "Please enter an email for password reset!", preferredStyle: .alert)
                           let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
                if (error == nil)
                {
                    print("Reset password success!")
                }
                else
                {
                    let alert:UIAlertController=UIAlertController(title: "Warning", message: "Reset password fail!", preferredStyle: .alert)
                                   let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                   alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
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
