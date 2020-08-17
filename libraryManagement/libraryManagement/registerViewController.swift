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

class registerViewController: UIViewController {
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
                            //let size = metadata.size
                            avatarRef.downloadURL { (url, error) in
                              guard let downloadURL = url else {
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
                                return
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
        password_1TextField.textContentType = .newPassword
        password_2TextField.textContentType = .newPassword
        
        // avatarImage.image = UIImage(contentsOfFile: "avatar")
        
        // Do any additional setup after loading the view.
    }
}

extension registerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chooseImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imgValue = max(chooseImg.size
            .width, chooseImg.size.height)
        if (imgValue > 3000) {
            imgData = chooseImg.jpegData(compressionQuality: 0.1)
        }
        else if (imgValue > 2000) {
            imgData = chooseImg.jpegData(compressionQuality: 0.3)
        }
        else {
            imgData = chooseImg.pngData()
        }
        avatarImage.image = UIImage(data: imgData)
        
        dismiss(animated: true, completion: nil)
    }
}
