//
//  registerViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class registerViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password_1TextField: UITextField!
    @IBOutlet weak var password_2TextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //---Action
    @IBAction func tapAvatar(_ sender: UITapGestureRecognizer) {
        let alert: UIAlertController = UIAlertController(title: "Notice", message: "Choose your avatar from", preferredStyle: .alert)
        let galleryButton: UIAlertAction = UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPicker.delegate = self
        }
        let cameraButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(galleryButton)
        alert.addAction(cameraButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: password_1TextField.text!) { authResult, error in
            if (error == nil)
            {
                
            }
            else
            {
                
            }
        }
    }
    
    //---Variable
    override func viewDidLoad() {
        super.viewDidLoad()
        password_1TextField.isSecureTextEntry  = true
        password_2TextField.isSecureTextEntry  = true
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
