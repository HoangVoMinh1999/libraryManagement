//
//  listBorrowingCardStudentViewController.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 6/10/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit

class listBorrowingCardStudentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:listBorrowingCardsStudentTableViewCell = listBorrowingCardTableView.dequeueReusableCell(withIdentifier: "listBorrowingCardsStudentTableViewCell") as! listBorrowingCardsStudentTableViewCell
        cell.IDcardLabel.text = ID[indexPath.row]
        cell.dateLabel.text = date[indexPath.row]
        cell.statusLabel.text = status[indexPath.row]
        return cell
    }
    
    //---Outlet
    @IBOutlet weak var listBorrowingCardTableView: UITableView!
    //---Variable
    var ID = ["1","2","3"]
    var date = ["1/1/2020","2/2/2020","3/3/2020"]
    var status = ["done","fined","Peding"]
    //---Action
    override func viewDidLoad() {
        super.viewDidLoad()
        listBorrowingCardTableView.dataSource = self
        listBorrowingCardTableView.delegate = self
        listBorrowingCardTableView.reloadData() 
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
