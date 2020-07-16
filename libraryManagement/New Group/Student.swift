//
//  Student.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation

class Student{
    var name:String;
    var ID:String;
    var birthday:String;
    var gender:String;
    var address:String;
    var email:String;
    var startedDay:String;
    var status:Bool;
    
    init() {
        name = ""
        ID = ""
        birthday = ""
        gender = ""
        address = ""
        email = ""
        startedDay=""
        status=true
    }
    
    init(name:String,ID:String,birthday:String,gender:String,address:String,email:String,startedDay:String,status:Bool) {
        self.name = name
        self.ID = ID
        self.birthday=birthday
        self.gender = gender
        self.address=address
        self.email=email
        self.startedDay = startedDay
        self.status = status
    }
}
