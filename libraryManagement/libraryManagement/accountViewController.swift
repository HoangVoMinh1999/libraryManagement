//
//  accountViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 30/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class accountViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    //---Action
    @IBAction func editButton(_ sender: Any) {
    }
    
    @IBAction func createButton(_ sender: Any) {
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to log out?", preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
                let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
            
            self.performSegue(withIdentifier: "unwindToLoginViewWithSegue", sender: self)
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: false,completion: nil)
    }
    
    @IBAction func unwindToAccountView(segue:UIStoryboardSegue){
    }
    
    //---Variable

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
