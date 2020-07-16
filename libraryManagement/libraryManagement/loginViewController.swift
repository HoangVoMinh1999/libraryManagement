//
//  loginViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //---Action
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if (error == nil) {
                print("Login success!")
                self!.loggedIn()
            }
            else
            {
                let alert:UIAlertController=UIAlertController(title: "Warning", message: "Wrong email or password!", preferredStyle: .alert)
                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okButton)
                self!.present(alert, animated: true, completion: nil)
            }
        }

    }
    @IBAction func forgetButton(_ sender: Any) {
    }
    //---Variable
    var Username:String = "hoang"
    var Password:String = "123456"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        passwordTextField.isSecureTextEntry = true
        
        loggedIn()
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

extension UIViewController {
    func loggedIn(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil){
                print("Logged in")
                let viewController=self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
                self.present(viewController, animated: true, completion: nil)
            }
            else{
                print("Not login")
            }
        }
    }
}
