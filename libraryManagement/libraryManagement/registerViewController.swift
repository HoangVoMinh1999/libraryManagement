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

class registerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextField.text = self.list[row]
    }
    
    //--Variable
    var imgData: Data!
    var list = ["Male","Female","Other"]

    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password_1TextField: UITextField!
    @IBOutlet weak var password_2TextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //---Action
    @IBAction func birthdayAction(_ sender: Any) {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
        datePicker.sizeToFit()
        datePicker.datePickerMode = .date
        alert.view.addSubview(datePicker)
        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.birthdayTextField.text = datePicker.date.dateToString()
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        //        alert.show()
        self.present(alert,animated:true,completion: nil)
    }
    
    @IBAction func genderAction(_ sender: Any) {
        genderTextField.text = "Male"
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let picker = UIPickerView(frame: CGRect(x: 30, y:0, width: 300, height: 400))
        picker.dataSource=self
        picker.delegate=self
        picker.sizeToFit()
        alert.view.addSubview(picker)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            self.genderTextField.text=""
        }
        alert.addAction(cancelButton)
        
        present(alert,animated: true,completion: nil)
    }
    
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
        if (nameTextField.text! == "" || birthdayTextField.text! == "" || genderTextField.text! == "" || emailTextField.text! == "" || password_1TextField.text! == "" || password_2TextField.text! == "") {
            let alert:UIAlertController=UIAlertController(title: "Warning", message: "Please fill all information", preferredStyle: .alert)
            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if (password_1TextField.text! != password_2TextField.text!) {
                let alert:UIAlertController=UIAlertController(title: "Warning", message: "Password confirm must be the same as password", preferredStyle: .alert)
                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            Auth.auth().createUser(withEmail: emailTextField.text!, password: password_1TextField.text!) { authResult, error in
                if (error == nil)
                {

                    let db = Firestore.firestore()
                    db.collection("Accounts").document(self.emailTextField.text!).setData(["name" : self.nameTextField.text,"birthday": self.birthdayTextField.text,"gender":self.genderTextField.text,"email": self.emailTextField.text,"avatar": "gs://librarymanagement-bd9ab.appspot.com/images/avatar.png"])
                    

                    let alert:UIAlertController=UIAlertController(title: "Login Success", message: error?.localizedDescription, preferredStyle: .alert)
                    let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        self.updateData()
                        
                        self.performSegue(withIdentifier: "unwindToAccountViewWithSegue", sender: self)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    let alert:UIAlertController=UIAlertController(title: "Warning", message: error?.localizedDescription, preferredStyle: .alert)
                    let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
       
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToAccountViewWithSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password_1TextField.isSecureTextEntry  = true
        password_2TextField.isSecureTextEntry  = true
        password_1TextField.textContentType = .newPassword
        password_2TextField.textContentType = .newPassword
        dismiss(animated: true, completion: nil)
        
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
    
    func updateData(){
        let queue: DispatchQueue = DispatchQueue(label: "UpdateImage")
        queue.async {
            do{
                let ref = Storage.storage().reference().child("images/\(self.emailTextField.text!)")
                 let metaData = StorageMetadata()
                let chooseImg = self.avatarImage.image
                let pickerData = chooseImg!.jpegData(compressionQuality: 1)!
                 metaData.contentType = "image/jpeg"
                 
                 ref.putData(pickerData, metadata: metaData){(metaData,err) in
                     guard metaData != nil else {
                         return
                     }
                     ref.downloadURL { (url, err) in
                         guard url != nil else {
                             return
                         }
                     }
                 }
            }
            DispatchQueue.main.async {
                let db = Firestore.firestore()
                db.collection("Accounts").document("\(self.emailTextField.text!)").updateData(["avatar" : "gs://librarymanagement-bd9ab.appspot.com/images/\(self.emailTextField.text!)"])
            }
        }

    }
}
