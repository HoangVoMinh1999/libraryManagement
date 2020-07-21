//
//  manageBooksViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit


class manageBooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tmp = UserDefaults()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmp.value(forKey: "amount_of_books") as! Int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data_books: Array<Dictionary<String,Any>> = tmp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
        let ID_books: Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        let cell: listBooksTableViewCell = booksTableView.dequeueReusableCell(withIdentifier: "listBooksTableViewCell") as! listBooksTableViewCell
        cell.bookIDLabel.text = data_books[indexPath.row]["ID"] as! String
        cell.booknameLabel.text = data_books[indexPath.row]["name"] as! String
        return cell
    }
    
    @IBOutlet weak var booksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.reloadData()


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
