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
    //---Variable
    var temp = UserDefaults()
    //---Action
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if (error == nil) {
                let queue:DispatchQueue = DispatchQueue(label: "Login")
                queue.async {
                    do{
                        let docRef = db.collection("Accounts").document("\(self!.emailTextField.text!)")

                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                self!.temp.set(document.data(), forKey: "current_user")
                            } else {
                                print("Document does not exist")
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        let viewController=self?.storyboard?.instantiateViewController(identifier: "mainViewController")
                        self!.present(viewController!, animated: true, completion: nil)
                    }
                }
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

    @IBAction func unwindToLoginView(segue:UIStoryboardSegue){
    }
    
    
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

}

extension UIViewController {
    func loggedIn(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil){
                print((user?.email)!)
            }
            else{
                print("Not login")
            }
        }
    }
}
