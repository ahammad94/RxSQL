//
//  Select.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3


public protocol TableSelector: SQLStatement { }

extension TableSelector {
    public func from(_ val: String) -> SQLTable {
        let newStatement = "\(statement) FROM"
        return SQLTable(statement: newStatement, tableName: val)
    }
}

public class Select: SQLStatement, TableSelector {
    public var statement: String
    
    init(_ toSelect: String) {
        statement = "SELECT \(toSelect)"
    }
    
    private init(statement: String) {
        self.statement = statement
    }
}
