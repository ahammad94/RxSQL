//
//  Insert.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public class Insert: SQLStatement {
    public var statement: String = ""
    
    public init(into val: String) {
        self.statement = "INSERT INTO \(val)"
    }
    
    private init(_ statement: String) {
        self.statement = statement
    }
    
    public func properties(_ keys: [String]) -> Insert {
        let newStatement = "\(statement) (\(keys.joined(separator: ","))) VALUES (\(keys.map { _ in "?" }.joined(separator: ",")))"
        return Insert(newStatement)
    }
}
