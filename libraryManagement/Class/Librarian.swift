//
//  File.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation

class Librarian{
    var name:String
    var email:String
    var phone:String
    
    init() {
        name = ""
        email = ""
        phone = ""
    }
    
    init(name:String,email:String,phone:String) {
        self.name = name
        self.email = email
        self.phone = phone
    }
    
}
