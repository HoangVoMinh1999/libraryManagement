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
    var temp = UserDefaults()
    //---Action

    @IBAction func unwindToMenuBook(segue:UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadBookData(temp: temp)
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
