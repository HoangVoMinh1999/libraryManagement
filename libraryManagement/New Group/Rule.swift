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
    
    func saveOrUpdateRules(){
        let db = Firestore.firestore()
        // Update one field, creating the document if it does not exist.
        db.collection("Rules").document("\(self.title)").setData([ "title":"\(self.title)","content":"\(self.content)" ], merge: true)
    }
    
}
