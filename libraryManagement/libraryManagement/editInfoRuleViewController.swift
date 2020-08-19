//
//  editInfoRuleViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 1/8/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class editInfoRuleViewController: UIViewController {
    //---Variable
    var temp: UserDefaults = UserDefaults()
    
    //---Outlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        if (contentTextField.text == ""){
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Please fill content of rule", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        } else {
            let new_rule:Rule = Rule(title: titleTextField.text!, content: contentTextField.text!)
            new_rule.saveOrUpdateRules()
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add successfully !!!", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "unwindToRule", sender: self)
            }
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToRule", sender: self)
    }
    
    //---Func
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let t: Dictionary<String,Any> = temp.value(forKey: "current_rule") as! Dictionary<String,Any>
        print(t)
        
        titleTextField.isEnabled = false
        contentTextField.layer.borderWidth = 2
        
        titleTextField.text = t["title"] as? String
        contentTextField.text = t["content"] as? String

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
