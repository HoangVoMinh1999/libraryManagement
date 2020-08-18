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
            let ID_books:Array<String> = temp.value(forKey: "ID_books") as! Array<String>
            if (ID_books.count == 1){
                print("1")
                let db = Firestore.firestore()
                let docRef = db.collection("Books").document("\(ID_books[0])")
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                        if (document["name"] as! String == ""){
                            new_book.updateDetail(ID: ID_books[0])
                            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add successfully !!!", preferredStyle: .alert)
                            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                                    self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
                            }
                            alert.addAction(okButton)
                            self.present(alert,animated: true,completion: nil)
                        }
                        else {
                            if (new_book.name == document.data()!["name"] as! String){
                                let alert:UIAlertController = UIAlertController(title: "Notice", message: "This book is existed", preferredStyle: .alert)
                                let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(okButton)
                                self.present(alert,animated: true,completion: nil)
                            } else {
                                new_book.insertNewBook()
                                let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add successfully !!!", preferredStyle: .alert)
                                let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                                        self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
                                }
                                alert.addAction(okButton)
                                self.present(alert,animated: true,completion: nil)
                            }
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            } else {
                print("2")
                temp.set(false, forKey: "check")
                let queue:DispatchQueue = DispatchQueue(label: "check")
                queue.async {
                    do {
                        self.checkNewBook(book: new_book, UserDefaults: self.temp)
                    }
                    DispatchQueue.main.async {
                        let check = self.temp.value(forKey: "check") as! Bool
                        print(check)
                        if (check == true){
                            print("del add dc")
                            let alert:UIAlertController = UIAlertController(title: "Notice", message: "This book is existed", preferredStyle: .alert)
                            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert,animated: true,completion: nil)
                        } else {
                            new_book.insertNewBook()
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

extension UIViewController{
    func checkNewBook(book:Book,UserDefaults:UserDefaults){
        let ID_books:Array<String> = UserDefaults.value(forKey: "ID_books") as! Array<String>
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
