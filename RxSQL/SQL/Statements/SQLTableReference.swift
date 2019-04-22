//
//  SQLTableReference.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/21/19.
//

import Foundation
import SQLite3

public class SQLTable: SQLStatement {
    public var statement: String
    
    internal init(statement: String, tableName: String) {
        self.statement = "\(statement) \(tableName)"
    }
    
    fileprivate init(statement: String) {
        self.statement = statement
    }
}

extension SQLTable {
    public func innerJoin(_ val: String) -> SQLTableUnfilteredJoin {
       let newStatement = "\(statement) INNER JOIN \(val)"
        return SQLTableUnfilteredJoin(statement: newStatement)
    }
    
    public func crossJoin(_ val: String) -> SQLTableUnfilteredJoin {
        let newStatement = "\(statement) CROSS JOIN \(val)"
        return SQLTableUnfilteredJoin(statement: newStatement)
    }
    
    public func outerJoin(_ val: String) -> SQLTableUnfilteredJoin {
        let newStatement = "\(statement) OUTER JOIN \(val)"
        return SQLTableUnfilteredJoin(statement: newStatement)
    }
}

public class SQLTableUnfilteredJoin: SQLStatement {
    public var statement: String
    
    fileprivate init(statement: String) {
        self.statement = statement
    }
    
    func on(_ val: String) -> SQLTable {
        let newStatement = "\(statement) ON \(val)"
        return SQLTable(statement: newStatement)
    }
}
