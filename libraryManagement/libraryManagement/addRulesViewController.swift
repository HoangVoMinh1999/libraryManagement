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
    @IBOutlet weak var contentTextField: UITextView!
    
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        if (titleTextField.text! == "" || contentTextField.text! == ""){
            let alert:UIAlertController=UIAlertController(title: "Warning!", message: "You need to fill all information", preferredStyle: .alert)
            let okButton:UIAlertAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            let new_rule = Rule(title: titleTextField.text!, content: contentTextField.text!)
            let alert:UIAlertController = UIAlertController(title: "Notice", message: "Add rule successfully!!!", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                let queue:DispatchQueue = DispatchQueue(label: "UpdateRules")
                queue.sync {
                    new_rule.saveOrUpdateRules()
                }
                queue.sync {
                    self.loadRuleData(temp: self.temp)
                }
                queue.sync {
                    print(self.temp.value(forKey: "ID_rules") as! Array<String>)
                    self.performSegue(withIdentifier: "unwindToRule", sender: self)
                }
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
        contentTextField.layer.borderWidth = 2
        contentTextField.text = ""
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        loadRuleData(temp: temp)
        print("3: \(temp.value(forKey: "ID_rules") as! Array<String>)")
    }

}
