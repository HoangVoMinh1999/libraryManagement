//
//  Account.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 17/8/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation
import Firebase

class Account{
    var name:String
    var birthday:String
    var gender:String
    var email:String
    var password:String
    var avatar:String
    var status:Int
    
    init() {
        name = ""
        birthday = ""
        gender = ""
        email = ""
        password = ""
        avatar = ""
        status = 1
    }
    
    init(name:String,birthday:String,gender:String,email:String,password:String,avatar:String,status:Int) {
        self.name = name
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.password = password
        self.avatar = avatar
        self.status = status
    }
    
    func insertNewAccount(){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil

        ref = db.collection("Accounts").addDocument(data: [
            "name":"\(self.name)",
            "birthday":"\(self.birthday)",
            "gender":"\(self.gender)",
            "email":"\(self.email)",
            "avatar":"\(self.avatar)",
            "status":"\(self.status)"
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
        db.collection("Accounts").document("\(ID)").setData([
            "name":"\(self.name)",
            "birthday":"\(self.birthday)",
            "gender":"\(self.gender)",
            "email":"\(self.email)",
            "avatar":"\(self.avatar)",
            "status":"\(self.status)"
        ], merge: true)
    }

    
}
