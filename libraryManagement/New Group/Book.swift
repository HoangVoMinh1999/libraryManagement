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
    var avatarURL:String
    
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
        avatarURL = ""
    }
    
    init(ID:String,name:String,category:String,author:String,publishingyear:String,publishingcompany:String,dateadded:String,status:Int,quantity:Int,check:Int,avatarURL:String) {
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
        self.avatarURL = avatarURL
    }
    
    func setQuantity(quantity:Int) -> Void {
        self.quantity = quantity
    }
    
    func saveOrUpdateNewBook(){
        let db = Firestore.firestore()
        db.collection("Books").document("\(self.ID)").setData(["ID":"\(self.ID)",
            "name":"\(self.name)",
            "category":"\(self.category)",
            "author":"\(self.author)",
            "publishingyear":"\(self.publishingyear)",
            "publishingcompany":"\(self.publishingcompany)",
            "dateadded":"\(self.dateadded)",
            "status":1,
            "quantity":"\(self.quantity)",
            "check":0,
            "avatarURL":"\(self.avatarURL)"], merge: true)
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
        "check":self.check,
        "avatarURL":"\(self.avatarURL)"
        ], merge: true)
    }

    
}
