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
        let currentBook:Book = Book(ID: bookIDTextField.text!, name: booknameTextField.text!.uppercased(), category: categoryTextField.text!, author: authorTextField.text!, publishingyear: publishingyearTextField.text!, publishingcompany: publishingcompanyTextField.text!, dateadded: dateaddedTextField.text!, status: true, quantity: Int(quantityTextField.text!)!)
        
        currentBook.updateDetail(currentBook: currentBook, ID: temp.value(forKey: "ID") as! String)
        
//        let src = (storyboard?.instantiateViewController(identifier: "bookMenuViewController")) as! bookMenuViewController
//        present(src, animated: true, completion: nil)
        self.performSegue(withIdentifier: "unwindToManageBookWithSegue", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToManageBookWithSegue", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let t:Dictionary<String,Any> = temp.value(forKey: "book") as! Dictionary<String, Any>
        
        bookIDTextField.text = t["ID"] as! String
        booknameTextField.text = t["name"] as! String
        categoryTextField.text = t["category"] as! String
        authorTextField.text = t["author"] as! String
        publishingyearTextField.text = t["publishingyear"] as! String
        publishingcompanyTextField.text = t["publishingcompany"] as! String
        dateaddedTextField.text = t["dateadded"] as! String
        quantityTextField.text = t["quantity"] as! String
        
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
