//
//  studentMenuViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class studentMenuViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var manageButton: UIButton!
    @IBOutlet weak var statisticButton: UIButton!
    
    //---Action
    @IBAction func unwindToMenuStudent(segue:UIStoryboardSegue){
    }
    //---Variable
    var temp:UserDefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.customMenuButton()
        manageButton.customMenuButton()
        statisticButton.customMenuButton()
        
        var ID_students:Array<String> = temp.value(forKey: "ID_students")! as! Array<String>
        var ID_rules:Array<String> = temp.value(forKey: "ID_rules")! as! Array<String>
        
        if (ID_students == []){
            let new_student:Student = Student()
            new_student.insertNewStudent()
        }
        if (ID_rules == []){
            let new_rule:Rule = Rule()
            new_rule.insertNewRule()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        temp.set([], forKey: "ID_students")
        temp.set([], forKey: "ID_rules")
        loadStudentData(temp: temp)
        loadRuleData(temp: temp)
    }
    
}

extension UIButton{
    func customMenuButton(){
        layer.cornerRadius = 30
    }
}
extension UIViewController{
    
    func loadStudentData(temp:UserDefaults) {
        let db = Firestore.firestore()
        
        db.collection("Students").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data_students:Array<Dictionary<String,Any>> = []
                var ID_students:Array<String> = []
                for document in querySnapshot!.documents {
                    data_students.append(document.data())
                    ID_students.append(document.documentID)
                }
                temp.set(ID_students, forKey: "ID_students")
            }
        }
    }
    
    func loadRuleData(temp:UserDefaults) {
        let db = Firestore.firestore()
        db.collection("Rules").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data_rules: Array<Dictionary<String,Any>> = []
                var ID_rules: Array<String> = []
                for document in querySnapshot!.documents {
                    data_rules.append(document.data())
                    ID_rules.append(document.documentID)
                }
                temp.set(ID_rules, forKey: "ID_rules")
            }
        }
    }
}
