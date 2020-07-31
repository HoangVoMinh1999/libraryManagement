//
//  addStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addStudentsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return list.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextField.text = self.list[row]
    }

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
    var list = ["Male","Female","Other"]
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
    
    
    
    @IBAction func birthdayAction(_ sender: UITextField) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
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
    
    

    @IBAction func startedDayAction(_ sender: Any) {
        let alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
        datePicker.sizeToFit()
        datePicker.datePickerMode = .date
        alert.view.addSubview(datePicker)
        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.starteddayTextField.text = datePicker.date.dateToString()
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        //        alert.show()
        self.present(alert,animated:true,completion: nil)
        
    }
    
    @IBAction func genderAction(_ sender: Any) {
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
    
    
    

    @IBAction func confirmButton(_ sender: Any) {

        //---Collect data new student
        let new_student:Student =  Student(name: nameTextField.text!, ID: IDTextField.text!, birthday: birthdayTextField.text!,gender:genderTextField.text!, address: addressTextField.text!, email: emailTextField.text!, startedDay: starteddayTextField.text!, status: true)
        
        // Add a new document with a generated ID
        new_student.insertNewStudent(newStudent:new_student)
        
        //---Change view to manageStudent view
        self.performSegue(withIdentifier: "unwindToMenuStudent", sender: self)
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        //--- Bugs in change view
        self.performSegue(withIdentifier: "unwindToMenuStudent", sender: self)
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

extension Date{
    func dateToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd-MM-yyyy"
        let str = dateFormatter.string(from: self)
        return str
    }
}

