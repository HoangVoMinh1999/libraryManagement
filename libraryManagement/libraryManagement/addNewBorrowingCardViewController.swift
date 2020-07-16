//
//  addNewBorrowingCardViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 7/16/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class addNewBorrowingCardViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    //---Action
    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "student") as! Dictionary<String, Any>
        nameTextField.isEnabled = false
        idTextField.isEnabled = false
        nameTextField.text = t["name"] as? String
        idTextField.text = t["ID"] as? String
        
        
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
