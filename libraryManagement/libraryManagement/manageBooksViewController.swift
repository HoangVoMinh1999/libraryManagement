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
//    var book = Book()
//    var data:Array<Dictionary<String,Any>> = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }


    
    //---Action
    @IBAction func unwindToManageBook(segue:UIStoryboardSegue){
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmp.value(forKey: "amount_of_books") as! Int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data_books: Array<Dictionary<String,Any>> = tmp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
        print(data_books)
        let ID_books: Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        let cell: listBooksTableViewCell = booksTableView.dequeueReusableCell(withIdentifier: "listBooksTableViewCell") as! listBooksTableViewCell
        cell.bookIDLabel.text = data_books[indexPath.row]["ID"] as! String
        cell.booknameLabel.text = data_books[indexPath.row]["name"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data:Array<Dictionary<String,Any>> = tmp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
        let ID:Array<String> = tmp.value(forKey: "ID_books") as! Array<String>
        
        tmp.set(data[indexPath.row], forKey: "book")
        tmp.set(ID[indexPath.row], forKey: "ID")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert:UIAlertController = UIAlertController(title: "Warning", message: "Do you want to delete this book?", preferredStyle: .alert)
            let okButton:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                
                self.booksTableView.deleteRows(at: [indexPath], with: .fade)
//                var data:Array<Dictionary<String,Any>> = self.tmp.value(forKey: "data_books") as! Array<Dictionary<String, Any>>
//                data[indexPath.row]["status"] = false
                
            }
            alert.addAction(okButton)
            let cancelButton:UIAlertAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(cancelButton)
            present(alert, animated: false,completion: nil)
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
//    func filterContentForSearchText(_ searchText: String,
//                                    category: ) {
//      filteredBooks = Book { (book: Book) -> Bool in
//        return book.name.lowercased().contains(searchText.lowercased())
//      }
//
//      tableView.reloadData()
//    }

    
    //---Outlet
    @IBOutlet weak var booksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        data = book.findAll()
//        print(data)
        
        booksTableView.delegate = self
        booksTableView.dataSource = self

        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true



        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                self.tmp.set(data_books, forKey: "data_books")
                self.tmp.set(ID_books, forKey: "ID_books")
                self.tmp.set(ID_books.count, forKey: "amount_of_books")
            }
        }
            booksTableView.reloadData()
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
extension manageBooksViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}
