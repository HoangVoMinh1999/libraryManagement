//
//  addBooksViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

let storage = Storage.storage()
let storageRef = storage.reference(forURL: "gs://librarymanagement-bd9ab.appspot.com")

class addBooksViewController: UIViewController{
    //---Outlet---
    @IBOutlet weak var bookIDTextField: UITextField!
    
    @IBOutlet weak var booknameTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var publishingyearTextField: UITextField!
    
    @IBOutlet weak var publishingcompanyTextField: UITextField!
    
    @IBOutlet weak var dateaddedTextField: UITextField!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var imgBook: UIImageView!
    
    //---Variable
    var temp = UserDefaults()
    var imgData:Data!
    //---Action---
    
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
    
    @IBAction func confirmButton(_ sender: Any) {
        if (booknameTextField.text == "" || bookIDTextField.text == "" || categoryTextField.text == "" || authorTextField.text == "" || publishingcompanyTextField.text == "" || publishingyearTextField.text == "" || dateaddedTextField.text == "" || quantityTextField.text == ""){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill all infomation !!!", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        } else {
            let new_book:Book = Book(ID: bookIDTextField.text!, name: booknameTextField.text!.uppercased(), category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!,publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: 1, quantity: Int(quantityTextField.text!)!, check: 0, avatarURL: "")
            temp.set(false, forKey: "check")
            var check = false
            let queue: DispatchQueue = DispatchQueue(label: "check data")
            queue.async {
                do{
                    self.checkNewBook(book: new_book, UserDefaults: self.temp)
                }
                DispatchQueue.main.async {
                    check = self.temp.value(forKey: "check") as! Bool
                    print(check)
                    if (check == true){
                        let alert:UIAlertController = UIAlertController(title: "Notice", message: "This book is existed", preferredStyle: .alert)
                        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert,animated: true,completion: nil)
                    } else{
                        let queue:DispatchQueue = DispatchQueue(label: "Update")
                        queue.async {
                            do{
                                new_book.saveOrUpdateNewBook()
                            }
                            DispatchQueue.main.async {
                                self.updateData()
                                let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add successfully !!!", preferredStyle: .alert)
                                let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                                        self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
                                }
                                alert.addAction(okButton)
                                self.present(alert,animated: true,completion: nil)
                            }
                        }
                    }

                }
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
    }
    
    

    @IBAction func dateaddedAction(_ sender: Any) {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y:0, width: 400, height: 300))
        datePicker.sizeToFit()
        datePicker.datePickerMode = .date
        alert.view.addSubview(datePicker)
        let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.dateaddedTextField.text = datePicker.date.dateToString()
        }
        alert.addAction(okButton)
        let cancelButton:UIAlertAction=UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        //        alert.show()
        self.present(alert,animated:true,completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBook.layer.borderWidth = 2
        imgBook.image = UIImage(named: "book")
        
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

extension UIViewController{
    func checkNewBook(book:Book,UserDefaults:UserDefaults){
        let ID_books:Array<String> = UserDefaults.value(forKey: "ID_books") as! Array<String>
        print(ID_books)
        for id in ID_books {
            let db = Firestore.firestore()
            let docRef = db.collection("Books").document("\(id)")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if (book.name == document["name"] as! String ){
                        UserDefaults.set(true, forKey: "check")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}


extension addBooksViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
        imgBook.image = UIImage(data: imgData)
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateData(){
        let queue: DispatchQueue = DispatchQueue(label: "UpdateImage")
        queue.async {
            do{
                let ref = Storage.storage().reference().child("books/\(self.bookIDTextField.text!)")
                 let metaData = StorageMetadata()
                let chooseImg = self.imgBook.image
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
                db.collection("Books").document("\(self.bookIDTextField.text!)").updateData(["avatarURL" : "gs://librarymanagement-bd9ab.appspot.com/books/\(self.bookIDTextField.text!)"])
            }
        }

    }
}
