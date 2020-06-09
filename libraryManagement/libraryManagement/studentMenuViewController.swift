//
//  studentMenuViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/9/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class studentMenuViewController: UIViewController {
    //---Outlet
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var manageButton: UIButton!
    @IBOutlet weak var statisticButton: UIButton!
    
    //---Action
    //---Variable

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.customMenuButton()
        manageButton.customMenuButton()
        statisticButton.customMenuButton()
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
