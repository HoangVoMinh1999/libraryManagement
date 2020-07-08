//
//  addStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addStudentsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var starteddayTextField: UITextField!
    @IBOutlet weak var imgItem: UIImageView!
    //---Variable
    var imgItemData:Data!
    //---Action
    @IBAction func avatarTapGesture(_ sender: UITapGestureRecognizer) {
        let alert:UIAlertController=UIAlertController(title: "Notice !!!", message: "Choose your photo in camera or gallery", preferredStyle: .alert)
        let cameraButton:UIAlertAction = UIAlertAction(title: "camera", style: .cancel) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                let photoPicker = UIImagePickerController()
                photoPicker.allowsEditing = false
                photoPicker.delegate = self
                photoPicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(photoPicker, animated: true, completion: nil)
            }
        }
        alert.addAction(cameraButton)
        let galleryButton:UIAlertAction = UIAlertAction(title: "gallery", style: .destructive) { (UIAlertAction) in
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                let photoPicker = UIImagePickerController()
                photoPicker.delegate = self
                photoPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(photoPicker,animated: true,completion: nil)
            }
        }
        alert.addAction(galleryButton)
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func birthdayValue(_ sender: Any) {
    }
    
    
    

    @IBAction func confirmButton(_ sender: Any) {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        //---Collect data new student
        let new_student:Student =  Student(name: nameTextField.text!, ID: IDTextField.text!, birthday: birthdayTextField.text!, address: addressTextField.text!, email: emailTextField.text!, startedDay: starteddayTextField.text!, status: true)
        //---Create dir path in Firebase
        let students = ref.child("students")
        let detail_student = students.child("detail")
        let detail = detail_student.childByAutoId()
        
        //---Make data to save in Firebase
        let n_student: Dictionary<String,Any> = ["name":"\(new_student.name)","ID":"\(new_student.ID)","birthday":"\(new_student.birthday)","address":"\(new_student.address)","email":"\(new_student.email)","startedDay":"\(new_student.startedDay)","status":"\(new_student.status)"]
        detail.setValue(n_student)
        //---Change view to manageStudent view
        let src = (storyboard?.instantiateViewController(identifier: "manageStudentsViewController"))! as manageStudentsViewController
        present(src, animated: true,completion: nil)
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        let src = (storyboard?.instantiateViewController(identifier: "manageStudentsViewController"))! as manageStudentsViewController
        present(src, animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgItem.isUserInteractionEnabled=true
        imgItem.isMultipleTouchEnabled=true
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

extension addStudentsViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgChosen = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let size = max(imgChosen.size.width,imgChosen.size.height)
        if (size > 3000){
            imgItemData = imgChosen.jpegData(compressionQuality: 0.1)
        }
        else if (size > 1000){
            imgItemData=imgChosen.jpegData(compressionQuality: 0.3)
        }
        else{
            imgItemData=imgChosen.jpegData(compressionQuality: 1)
        }
        //---ImageItem= imgChosen
        imgItem.image=UIImage(data: imgItemData)
        dismiss(animated: true, completion: nil)
    }
}
