//
//  SQLDone.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public class SQLDone: SQLResult {
    public var statmentPointer: OpaquePointer?
    
    init(_ statementPointer: OpaquePointer?) {
        self.statmentPointer = statementPointer
    }
}
