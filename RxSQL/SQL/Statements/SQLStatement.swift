//
//  Entity.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/9/19.
//

import Foundation
import SQLite3
import RxSwift

public protocol SQLStatement: class {
    var statement: String { get set }
}

extension SQLStatement {
    
    public func executable(db: DatabaseReference?) -> SQLExecutable {
        // Create an opaque pointer for the statement
        var sqlStatementpointer: OpaquePointer? = nil
        
        // Prepare the statement for execution based on the string statement
        guard sqlite3_prepare_v2(db?.dbPointer, statement, -1, &sqlStatementpointer, nil) == SQLITE_OK else {
            fatalError("Bad sql statement: \(statement)")
        }
        
        return SQLExecutable(sqlStatementpointer)
    }
}

public enum RxSQLError: Error {
    case errorPreparingStatement
    case errorEvaluatingStatement
    case badReturnTypePassed
}
