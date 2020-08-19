//
//  statisticStudentsViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class statisticStudentsViewController: UIViewController {
    @IBOutlet weak var totalStudentLabel: UILabel!
    @IBOutlet weak var availableStudentLabel: UILabel!
    @IBOutlet weak var disabledStudentLabel: UILabel!
    //---Variable
    var temp:UserDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("Students").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.totalStudentLabel.text = "\(querySnapshot!.documents.count)"
                var count = 0
                for document in querySnapshot!.documents {
                    if ((document.data()["status"]) as! String == "1"){
                        count += 1
                    }
                }
                self.availableStudentLabel.text = "\(count)"
                self.disabledStudentLabel.text = "\((querySnapshot?.documents.count)! - count)"
            }
        }
        // Do any additional setup after loading the view.
    }
    func availableStudents(data:Array<Dictionary<String,Any>>) -> Int {
        var count = 0
        for i in data {
            if (i["status"] as! String == "1"){
                count += 1
            }
        }
        return count
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
