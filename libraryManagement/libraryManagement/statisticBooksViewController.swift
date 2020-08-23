//
//  statisticBooksViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class statisticBooksViewController: UIViewController {
    
    //---Outlet
    @IBOutlet weak var totalBookLabel: UILabel!
    @IBOutlet weak var totalBorrowingLabel: UILabel!
    @IBOutlet weak var totalRemainingLabel: UILabel!
    
    //---Variable
    var temp: UserDefaults = UserDefaults()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("Books").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var total = 0
                var check = 0
                for document in querySnapshot!.documents {
                    let quantity = Int(document.data()["quantity"] as! String)
                    let t = document.data()["check"] as! Int
                    total += quantity!
                    check += t
                }
                self.totalBookLabel.text = "\(total)"
                self.totalBorrowingLabel.text = "\(check)"
                self.totalRemainingLabel.text = "\(total - check)"
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
