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
    
    //---Action---
    @IBAction func confirmButton(_ sender: Any) {
        let new_book = Book(ID: bookIDTextField.text! ,name: booknameTextField.text!, category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!, publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: true)
        
        
        if (new_book.ID == "" || new_book.name == "" || new_book.category == "" || new_book.author == "" || new_book.publishingyear == "" || new_book.publishingcompany == "" || new_book.dateadded == ""){
            let alert:UIAlertController=UIAlertController(title: "Warning!", message: "You need to fill all information", preferredStyle: .alert)
            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            new_book.insertNewBook(newBook: new_book)
            self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
        }
    }

    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
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
