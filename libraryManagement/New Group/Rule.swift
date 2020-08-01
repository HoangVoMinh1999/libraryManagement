//
//  Rule.swift
//  libraryManagement
//
//  Created by Ha Cao Duy on 31/7/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation
import Firebase

class Rule{
    var title:String
    var content:String
    
    init() {
        title = ""
        content = ""
    }
    
    init(title:String,content:String) {
        self.title = title
        self.content = content
    }
    
    func insertNewRule(newRule:Rule){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil

        ref = db.collection("Rules").addDocument(data: [
            "title":"\(newRule.title)",
            "content":"\(newRule.content)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func updateDetail(currentRule:Rule,ID:String){
        let db = Firestore.firestore()
        let ref: DocumentReference? = nil
        db.collection("Rules").document("\(ID)").setData([
            "title":"\(currentRule.title)",
            "content":"\(currentRule.content)"
        ], merge: true)
    }
}
