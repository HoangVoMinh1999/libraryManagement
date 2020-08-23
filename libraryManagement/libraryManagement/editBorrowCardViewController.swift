//
//  editBorrowCardViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 8/19/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class editBorrowCardViewController: UIViewController {
    //---Variable
    var temp = UserDefaults()
    //---Outlet
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var bookIDTextField: UITextField!
    @IBOutlet weak var startedDayTextField: UITextField!
    @IBOutlet weak var endedDayTextField: UITextField!
    @IBOutlet weak var fineTextField: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    //---Action
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let student:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_student") as! String)") as! Dictionary<String, Any>
        
        let bc:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_bc") as! String)") as! Dictionary<String, Any>
        
        studentIDTextField.text = student["name"] as! String
        studentIDTextField.text = bc["ID_student"] as! String
        bookIDTextField.text = bc["ID_book"] as! String
        startedDayTextField.text = bc["startedDay"] as! String
        endedDayTextField.text = bc["endedDay"] as! String
        fineTextField.text = bc["fine"] as! String
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
