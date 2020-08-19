//
//  manageBooksViewController.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 23/6/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import UIKit
import Firebase


class manageBooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //---Variable
    var tmp = UserDefaults()
    
    //---Action
    @IBAction func unwindToManageBook(segue:UIStoryboardSegue){
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ID_books:Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        return ID_books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID_books:Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        let cell: listBooksTableViewCell = booksTableView.dequeueReusableCell(withIdentifier: "listBooksTableViewCell") as! listBooksTableViewCell
        let db = Firestore.firestore()
        db.collection("Books").document("\(ID_books[indexPath.row])")
        .addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            if (document.data()!["name"]! as? String != ""){
                cell.bookIDLabel.text = document.data()!["ID"]! as? String
                cell.booknameLabel.text = document.data()!["name"]! as? String
                self.tmp.set(document.data(), forKey: "\(ID_books[indexPath.row])")
                self.noticeLabel.isHidden = true
                self.addBookButton.isHidden = true
            } else {
                cell.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ID_books:Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        self.tmp.setValue(ID_books[indexPath.row], forKey: "ID_current_book")
            
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to delete this book?", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                
                self.booksTableView.deleteRows(at: [indexPath], with: .fade)
            }
            alert.addAction(okButton)
            let cancelButton:UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(cancelButton)
            present(alert, animated: false,completion: nil)
        }
    }
    


    
    //---Outlet
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var addBookButton: UIButton!
    
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

