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
        var data: Array<Dictionary<String,Any>> = temp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
        totalBookLabel.text = "\(totalBooks(data: data))"

        // Do any additional setup after loading the view.
    }
    
    func totalBooks(data:Array<Dictionary<String,Any>>) -> Int {
        var count = 0
        for i in data {
            count += Int(i["quantity"] as! String)!
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
