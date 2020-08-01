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
    @IBOutlet weak var contentTextField: UITextField!
    
    //---Action
    @IBAction func confirmButton(_ sender: Any) {
        let currentRule:Rule = Rule(title: titleTextField.text!, content: contentTextField.text!)
        
        currentRule.updateDetail(currentRule: currentRule, ID: temp.value(forKey: "ID_current_rule") as! String)
        
        self.performSegue(withIdentifier: "unwindToRuleWithSegue", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToRuleWithSegue", sender: self)
    }
    
    //---Func
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let t:Dictionary<String,Any> = temp.value(forKey: "\(temp.value(forKey: "ID_current_rule")!)") as! Dictionary<String, Any>
        print(t)
        
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
