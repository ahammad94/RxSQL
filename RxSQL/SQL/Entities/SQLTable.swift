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
    public func innerJoin(_ val: String) -> SQLUnconditionalJoinedTable {
       let newStatement = "\(statement) JOIN \(val)"
        return SQLUnconditionalJoinedTable(statement: newStatement)
    }
    
    public func crossJoin(_ val: String) -> SQLTable {
        let newStatement = "\(statement) CROSS JOIN \(val)"
        return SQLTable(statement: newStatement)
    }
    
    public func outerJoin(_ val: String) -> SQLUnconditionalJoinedTable {
        let newStatement = "\(statement) LEFT OUTER JOIN \(val)"
        return SQLUnconditionalJoinedTable(statement: newStatement)
    }
    
    public func `where`(_ val: String) -> SQLTable {
        let newStatement = "\(statement) WHERE \(val)"
        return SQLTable(statement: newStatement)
    }
}

public class SQLUnconditionalJoinedTable: SQLStatement {
    public var statement: String
    
    fileprivate init(statement: String) {
        self.statement = statement
    }
    
    func on(_ val: String) -> SQLTable {
        let newStatement = "\(statement) ON \(val)"
        return SQLTable(statement: newStatement)
    }
    
    func using(_ val: String) -> SQLTable {
        let newStatement = "\(statement) USING \(val)"
        return SQLTable(statement: newStatement)
    }
}


public enum OuterJoinType {
    case left
    case right
}
