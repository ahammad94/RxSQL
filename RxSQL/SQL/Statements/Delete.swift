//
//  Delete.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/22/19.
//

import Foundation
import SQLite3

public class Delete: SQLStatement, TableSelector {
    public var statement: String
    
    init() {
        statement = "DELETE"
    }
    
    private init(statement: String) {
        self.statement = statement
    }
}
