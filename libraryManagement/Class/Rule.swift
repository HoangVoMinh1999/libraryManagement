//
//  Rule.swift
//  LibraryManagement
//
//  Created by Hoàng Võ Minh on 5/25/20.
//  Copyright © 2020 HD team. All rights reserved.
//

import Foundation

class Rule{
    var rulesOfStudent:[String]
    var rulesOfBorrowingBook:[String]
    var rulesOfNewBook:[String]
    
    init() {
        rulesOfStudent=[]
        rulesOfBorrowingBook=[]
        rulesOfNewBook=[]
    }
    
    init(student:[String],book:[String],newBook:[String]) {
        self.rulesOfStudent=student
        self.rulesOfBorrowingBook=book
        self.rulesOfNewBook=newBook
    }
}
