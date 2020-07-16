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
                self.temp.set(data_students, forKey: "data_students")
                self.temp.set(data_students.count, forKey: "amount_of_students")
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
