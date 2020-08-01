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
    var temp = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.customMenuButton()
        manageButton.customMenuButton()
        statisticButton.customMenuButton()
        
        
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
                self.temp.set(ID_students, forKey: "ID_students")
            }
        }
        
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
                self.temp.set(ID_rules, forKey: "ID_rules")
            }
        }
        
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

extension UIButton{
    func customMenuButton(){
        layer.cornerRadius = 30
    }
}
