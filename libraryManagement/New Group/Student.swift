//
//  Student.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation
import Firebase

class Student{
    var name:String;
    var ID:String;
    var birthday:String;
    var gender:String;
    var address:String;
    var email:String;
    var startedDay:String;
    var status:Int;
    
    init() {
        name = ""
        ID = ""
        birthday = ""
        gender = ""
        address = ""
        email = ""
        startedDay=""
        status=1
    }
    
    init(name:String,ID:String,birthday:String,gender:String,address:String,email:String,startedDay:String,status:Int) {
        self.name = name
        self.ID = ID
        self.birthday=birthday
        self.gender = gender
        self.address=address
        self.email=email
        self.startedDay = startedDay
        self.status = status
    }
    
    func insertNewStudent(){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("Students").addDocument(data: ["name":"\(self.name)","ID":"\(self.ID)","birthday":"\(self.birthday)","gender":"\(self.gender)","address":"\(self.address)","email":"\(self.email)","startedDay":"\(self.startedDay)","status":"1"]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func updateDetail(ID:String){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        db.collection("Students").document("\(ID)").setData(["name":"\(self.name)","ID":"\(self.ID)","birthday":"\(self.birthday)","gender":"\(self.gender)","address":"\(self.address)","email":"\(self.email)","startedDay":"\(self.startedDay)","status":"\(self.status)"], merge: true)
    }
}
