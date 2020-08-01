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
//    @IBAction func confirmButton(_ sender: Any) {
//        let ls_data:Array<Dictionary<String,Any>> = temp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
//        let ls_ID:Array<String> = temp.value(forKey: "ID_books") as! Array<String>
//        if (bookIDTextField.text! == "" || booknameTextField.text! == "" || categoryTextField.text! == "" || authorTextField.text! == "" || publishingyearTextField.text! == "" || publishingcompanyTextField.text! == "" || dateaddedTextField.text! == ""){
//            let alert:UIAlertController=UIAlertController(title: "Warning!", message: "You need to fill all information", preferredStyle: .alert)
//            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okButton)
//            present(alert, animated: true, completion: nil)
//        } else {
//            var position = 0
//            for i in ls_data {
//                if (i["name"] as! String == booknameTextField.text!.uppercased() ){
//                    let new_book = Book(ID: i["ID"] as! String ,name: i["name"] as! String, category: i["category"] as! String, author: i["author"] as! String, publishingyear: i["publishingyear"] as! String, publishingcompany: i["publishingcompany"] as! String, dateadded: i["dateadded"] as! String, status: Bool(i["status"] as! String)!, quantity: Int(i["quantity"] as! String)!)
//                    new_book.setQuantity(quantity: Int(i["quantity"] as! String)! + Int(quantityTextField.text!)!)
//                    new_book.updateDetail(currentBook: new_book, ID: ls_ID[position])
//                    let src = (storyboard?.instantiateViewController(identifier: "bookMenuViewController"))! as bookMenuViewController
//                    present(src, animated: true,completion: nil)
//                    return
//                }
//                position += 1
//            }
//            let new_book = Book(ID: bookIDTextField.text! ,name: booknameTextField.text!.uppercased(), category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!, publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: true, quantity: Int(quantityTextField.text!)!)
//            new_book.insertNewBook(newBook: new_book)
//
//            self.performSegue(withIdentifier: "unwindToMenuBookWithSegue", sender: self)
//        }
//
//    }
    
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
