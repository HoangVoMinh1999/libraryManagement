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
    var status:Int
    var quantity:Int
    var check:Int
    
    init() {
        ID = ""
        name = ""
        category = ""
        author = ""
        publishingyear = ""
        publishingcompany = ""
        dateadded = ""
        status = 1
        quantity = 0
        check = 0
    }
    
    init(ID:String,name:String,category:String,author:String,publishingyear:String,publishingcompany:String,dateadded:String,status:Int,quantity:Int,check:Int) {
        self.ID=ID
        self.name=name
        self.category=category
        self.author=author
        self.publishingyear=publishingyear
        self.publishingcompany=publishingcompany
        self.dateadded=dateadded
        self.status=status
        self.quantity=quantity
        self.check=check
    }
    
    func setQuantity(quantity:Int) -> Void {
        self.quantity = quantity
    }
    
    func insertNewBook(){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil

        ref = db.collection("Books").addDocument(data: [
            "ID":"\(self.ID)",
            "name":"\(self.name)",
            "category":"\(self.category)",
            "author":"\(self.author)",
            "publishingyear":"\(self.publishingyear)",
            "publishingcompany":"\(self.publishingcompany)",
            "dateadded":"\(self.dateadded)",
            "status":1,
            "quantity":"\(self.quantity)",
            "check":0
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func updateDetail(ID:String){
        let db = Firestore.firestore()
        let ref: DocumentReference? = nil
        db.collection("Books").document("\(ID)").setData([
            "ID":"\(self.ID)",
        "name":"\(self.name)",
        "category":"\(self.category)",
        "author":"\(self.author)",
        "publishingyear":"\(self.publishingyear)",
        "publishingcompany":"\(self.publishingcompany)",
        "dateadded":"\(self.dateadded)",
        "status":"\(self.status)",
        "quantity":"\(self.quantity)",
        "check":"\(self.check)"
        ], merge: true)
    }

    
}
