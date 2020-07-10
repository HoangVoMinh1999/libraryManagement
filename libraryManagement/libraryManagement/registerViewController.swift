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
import FirebaseStorage

let storage = Storage.storage()
let storageRef = storage.reference(forURL: "gs://librarymanagement-bd9ab.appspot.com")

class registerViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //--Variable
    var imgData: Data!
    
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
        let alert: UIAlertController = UIAlertController(title: "Notice", message: "Choose your avatar from:", preferredStyle: .alert)
        let galleryButton: UIAlertAction = UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
        let cameraButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                let imgPicker = UIImagePickerController()
                imgPicker.sourceType = UIImagePickerController.SourceType.camera
                imgPicker.delegate = self
                imgPicker.allowsEditing = false
                self.present(imgPicker, animated: true, completion: nil)
            }
        }
        
        alert.addAction(galleryButton)
        alert.addAction(cameraButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: password_1TextField.text!) { authResult, error in
            if (error == nil)
            {
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.password_1TextField.text!) { [weak self] authResult, error in guard let strongSelf = self else { return
                    }
                    if (error == nil)
                    {
                        print("Login success!")
                    }
                }
                
                let avatarRef = storageRef.child("images/\(self.emailTextField.text!).jpg")
                
                let uploadTask = avatarRef.putData(self.imgData, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        if (error != nil)
                        {
                            let alert:UIAlertController=UIAlertController(title: "Warning", message: "Fail to upload avatar", preferredStyle: .alert)
                            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = self.nameTextField.text!
                            changeRequest?.commitChanges { (error) in
                                if (error == nil)
                                {
                                    print("Register success!")
                                }
                                else
                                {
                                    let alert:UIAlertController=UIAlertController(title: "Warning", message: "Fail to update profile", preferredStyle: .alert)
                                    let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alert.addAction(okButton)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                        return
                    }
                }
                
                uploadTask.resume()

            }
            else
            {
                let alert:UIAlertController=UIAlertController(title: "Warning", message: "Fail to register", preferredStyle: .alert)
                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
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
