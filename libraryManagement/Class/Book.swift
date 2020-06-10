//
//  Book.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation

class Book{
    var name:String
    var type:String
    var author:String
    var releaseDay:String
    var publisher:String
    var startedDay:String
    
    init() {
        name = ""
        type = ""
        author = ""
        releaseDay = ""
        publisher = ""
        startedDay = ""
    }
    
    init(name:String,type:String,author:String,releaseDay:String,publisher:String,startedDay:String) {
        self.name=name
        self.type=type
        self.author=author
        self.releaseDay=releaseDay
        self.publisher=publisher
        self.startedDay=startedDay
    }
}
