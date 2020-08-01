//
//  addRulesViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 31/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class addRulesViewController: UIViewController {
    //---Variable
    var temp = UserDefaults()
    
    //---Outlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        if (titleTextField.text! == "" || contentTextField.text! == ""){
            let alert:UIAlertController=UIAlertController(title: "Warning!", message: "You need to fill all information", preferredStyle: .alert)
            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            let new_rule = Rule(title: titleTextField.text!, content: contentTextField.text!)
            new_rule.insertNewRule(newRule: new_rule)
        }

        self.performSegue(withIdentifier: "unwindToRuleWithSegue", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToRuleWithSegue", sender: self)
    }
    
    
    //---Func

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
