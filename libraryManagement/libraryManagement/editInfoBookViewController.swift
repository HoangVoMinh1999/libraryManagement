//
//  editInfoBookViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class editInfoBookViewController: UIViewController {
    
    
    //---Outlet
    @IBOutlet weak var bookIDTextField: UITextField!
    @IBOutlet weak var booknameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publishingyearTextField: UITextField!
    @IBOutlet weak var publishingcompanyTextField: UITextField!
    @IBOutlet weak var dateaddedTextField: UITextField!
    @IBOutlet weak var imgBook: UIImageView!
    
    //---Variable
    var temp: UserDefaults = UserDefaults()
    
    
    //---Action
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
    
    
    @IBAction func confirmButton(_ sender: Any) {
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_book")!)") as! Dictionary<String, Any>
        print(t)
        let currentBook:Book = Book()
        currentBook.name = booknameTextField.text!.uppercased()
        currentBook.author = authorTextField.text!
        currentBook.avatarURL = t["avatarURL"] as! String
        currentBook.category = categoryTextField.text!
        currentBook.dateadded = dateaddedTextField.text!
        currentBook.ID = bookIDTextField.text!
        currentBook.publishingcompany = publishingcompanyTextField.text!
        currentBook.publishingyear = publishingyearTextField.text!
        currentBook.check = t["check"] as! Int
        if (Int(quantityTextField.text!)! < t["check"] as! Int){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Not suitable quantity !!!", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert,animated: true,completion: nil)
        } else {
            currentBook.quantity = Int(quantityTextField.text!)!
        }
        
        currentBook.updateDetail(ID: temp.value(forKey: "ID_current_book") as! String)
        
        let alert:UIAlertController = UIAlertController(title: "Notice", message: "Update successfully !!!", preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "unwindToManageBookWithSegue", sender: self)
        }
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToManageBookWithSegue", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_book")!)") as! Dictionary<String, Any>
        
        bookIDTextField.text = t["ID"] as? String
        booknameTextField.text = t["name"] as? String
        categoryTextField.text = t["category"] as? String
        authorTextField.text = t["author"] as? String
        publishingyearTextField.text = t["publishingyear"] as? String
        publishingcompanyTextField.text = t["publishingcompany"] as? String
        dateaddedTextField.text = t["dateadded"] as? String
        quantityTextField.text = t["quantity"] as? String
        // Do any additional setup after loading the view.
        
        bookIDTextField.isEnabled = false
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
