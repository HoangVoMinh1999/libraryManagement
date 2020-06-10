//
//  FormOfBorrowingBook.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation


class Form{
    var book:String
    var type:String
    var author:String
    
    init() {
        book=""
        type=""
        author=""
    }
    
    init(book:String,type:String,author:String) {
        self.book=book
        self.type=type
        self.author=author
    }
}
