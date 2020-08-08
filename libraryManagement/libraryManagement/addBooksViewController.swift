//
//  addBooksViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addBooksViewController: UIViewController {
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
    //---Action---
    @IBAction func confirmButton(_ sender: Any) {
        if (booknameTextField.text == "" || bookIDTextField.text == "" || categoryTextField.text == "" || authorTextField.text == "" || publishingcompanyTextField.text == "" || publishingyearTextField.text == "" || dateaddedTextField.text == "" || quantityTextField.text == ""){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill all infomation !!!", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        } else {
            let new_book:Book = Book(ID: bookIDTextField.text!, name: booknameTextField.text!.uppercased(), category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!,publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: 1, quantity: Int(quantityTextField.text!)!, check: 0)
            let ID_books:Array<String> = self.temp.value(forKey: "ID_books") as! Array<String>
            for id in ID_books {
                let db = Firestore.firestore()
                db.collection("Books").document("\(id)")
                .addSnapshotListener { documentSnapshot, error in
                  guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                  }
                  guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                  }
                  if (data["name"] as! String == new_book.name){
                    let alert:UIAlertController=UIAlertController(title: "Notice", message: "This book is existed", preferredStyle: .alert)
                    let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true,completion: nil)
                    return
                  } else if (data["name"] as! String == ""){
                    new_book.updateDetail(ID: id)
                    return
                  }
                }
            }
            new_book.insertNewBook()
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
