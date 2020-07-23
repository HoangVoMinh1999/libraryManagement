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
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
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
