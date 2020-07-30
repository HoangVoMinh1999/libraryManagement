//
//  Book.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation
import Firebase

class Book{
    var ID:String
    var name:String
    var category:String
    var author:String
    var publishingyear:String
    var publishingcompany:String
    var dateadded:String
    var status:Bool
    var quantity:Int
    
    init() {
        ID = ""
        name = ""
        category = ""
        author = ""
        publishingyear = ""
        publishingcompany = ""
        dateadded = ""
        status = true
        quantity = 0
    }
    
    init(ID:String,name:String,category:String,author:String,publishingyear:String,publishingcompany:String,dateadded:String,status:Bool,quantity:Int) {
        self.ID=ID
        self.name=name
        self.category=category
        self.author=author
        self.publishingyear=publishingyear
        self.publishingcompany=publishingcompany
        self.dateadded=dateadded
        self.status=status
        self.quantity=quantity
    }
    
    func setQuantity(quantity:Int) -> Void {
        self.quantity = quantity
    }
    
    func insertNewBook(newBook:Book){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil

        ref = db.collection("Books").addDocument(data: [
            "ID":"\(newBook.ID)",
            "name":"\(newBook.name)",
            "category":"\(newBook.category)",
            "author":"\(newBook.author)",
            "publishingyear":"\(newBook.publishingyear)",
            "publishingcompany":"\(newBook.publishingcompany)",
            "dateadded":"\(newBook.dateadded)",
            "status":"true",
            "quantity":"\(newBook.quantity)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func updateDetail(currentBook:Book,ID:String){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        db.collection("Books").document("\(ID)").setData([
        "ID":"\(currentBook.ID)",
        "name":"\(currentBook.name)",
        "category":"\(currentBook.category)",
        "author":"\(currentBook.author)",
        "publishingyear":"\(currentBook.publishingyear)",
        "publishingcompany":"\(currentBook.publishingcompany)",
        "dateadded":"\(currentBook.dateadded)",
        "status":"\(currentBook.status)",
        "quantity":"\(currentBook.quantity)"], merge: true)
    }
    
//    func findAll() -> Array<Dictionary<String, Any>> {
//        let db = Firestore.firestore()
//        var data_books: Array<Dictionary<String,Any>> = []
//        db.collection("Books").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//
//                var ID_books: Array<String> = []
//                for document in querySnapshot!.documents {
//                    data_books.append(document.data())
//                    ID_books.append(document.documentID)
//                }
//                print(data_books)
////                return data_books
//            }
//        }
//        return data_books
//    }
}
