//
//  editAccountViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 30/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class editAccountViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password_1TextField: UITextField!
    @IBOutlet weak var password_2TextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
    
    
    //---Variable
    

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