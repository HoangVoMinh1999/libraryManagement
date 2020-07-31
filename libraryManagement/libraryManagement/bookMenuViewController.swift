//
//  bookMenuViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase

class bookMenuViewController: UIViewController {
    //---Outlet
    //---Variable
    var tmp = UserDefaults()
    //---Action

    @IBAction func unwindToMenuBook(segue:UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
            
        db.collection("Books").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data_books: Array<Dictionary<String,Any>> = []
                var ID_books: Array<String> = []
                for document in querySnapshot!.documents {
                    data_books.append(document.data())
                    ID_books.append(document.documentID)
                }
                self.tmp.set(ID_books, forKey: "ID_books")
            }
        }
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
