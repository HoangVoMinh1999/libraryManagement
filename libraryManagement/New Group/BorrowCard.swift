//
//  BorrowCard.swift
//  libraryManagement
//
//  Created by Hoàng Võ Minh on 7/31/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation
import Firebase



class  BorrowCard{
    var ID_student:String
    var ID_book:String
    var startedDay:String
    var endedDay:String
    var status:Int
    var fine:Int
    init() {
        ID_student = ""
        ID_book = ""
        startedDay = ""
        endedDay = ""
        status = 1
        fine = 0
    }
    
    func addCard() {
        // Add a new document with a generated id.
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("BorrowCard").addDocument(data: [
            "ID_student":"\(self.ID_student)",
            "ID_book":"\(self.ID_book)",
            "startedDay":"\(self.endedDay)",
            "endedDay":"",
            "status":"\(self.status)",
            "fine":"\(self.fine)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func updateCard(ID:String){
        let db = Firestore.firestore()
        let ref: DocumentReference? = nil
        db.collection("BorrowCard").document("\(ID)").setData([
            "ID_student":"\(self.ID_student)",
            "ID_book":"\(self.ID_book)",
            "startedDay":"\(self.endedDay)",
            "endedDay":"",
            "status":"\(self.status)",
            "fine":"\(self.fine)"
        ], merge: true)
    }
}
