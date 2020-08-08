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
        let new_book:Book = Book(ID: bookIDTextField.text!, name: booknameTextField.text!, category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!,publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: 1, quantity: Int(quantityTextField.text!)!, check: 0)
        let ID_books:Array<String> = temp.value(forKey: "ID_books") as! Array<String>
        
        
        if (ID_books.count == 1){
            let db = Firestore.firestore()
            db.collection("Books").document("\(ID_books[0])")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
                if (data["name"] as! String == ""){
                    new_book.updateDetail(ID: ID_books[0])
                }
                else{
                    new_book.insertNewBook()
                }
            }
        } else {
            new_book.insertNewBook()
        }
        self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
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
