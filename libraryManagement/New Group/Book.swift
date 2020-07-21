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
    
    init() {
        ID = ""
        name = ""
        category = ""
        author = ""
        publishingyear = ""
        publishingcompany = ""
        dateadded = ""
        status = true
    }
    
    init(ID:String,name:String,category:String,author:String,publishingyear:String,publishingcompany:String,dateadded:String,status:Bool) {
        self.ID=ID
        self.name=name
        self.category=category
        self.author=author
        self.publishingyear=publishingyear
        self.publishingcompany=publishingcompany
        self.dateadded=dateadded
        self.status=status
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
            "status":"true"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
