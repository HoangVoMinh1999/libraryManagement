//
//  loginViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //---Action
    @IBAction func loginButton(_ sender: Any) {
        print("login 1")
        let username = usernameTextField.text
        let password = passwordTextField.text
        if (Username == username && Password == password){
            print("login 2")
            let mainViewController = (storyboard?.instantiateViewController(identifier: "mainViewController")) as! UITabBarController 
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    @IBAction func forgetButton(_ sender: Any) {
    }
    //---Variable
    var Username:String = "hoang"
    var Password:String = "123456"
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
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
