//
//  CreateTable.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public class CreateTable: SQLStatement {
    public var statement: String = ""
    private var numberOfProperties = 0
    
    public init(_ val: String) {
        self.statement = "CREATE TABLE \(val)"
    }
    
    private init(_ statement: String, numberOfProperties: Int) {
        self.statement = statement
        self.numberOfProperties = numberOfProperties
    }
}


extension CreateTable {
    func setProperty(_ name: String, type: SupportedType.Type, canBeNull: Bool, isPrimaryKey: Bool = false,
                     autoIncrement: Bool = false) -> CreateTable {
        let nullModifier = canBeNull ? "" : " NOT NULL"
        let primaryKeyModifier = isPrimaryKey ? " PRIMARY KEY" : ""
        let autoIncrementModifier = autoIncrement ? " AUTOINCREMENT " : ""
        
        let toAdd = " \(name) \(type.toSql())\(primaryKeyModifier)\(nullModifier)\(autoIncrementModifier)"
        
        var newStatement = String(statement)
        
        if numberOfProperties == 0 {
            newStatement += "(\n"
        } else {
            newStatement = String(statement.dropLast(4))
            newStatement += ",\n"
        }
        
        newStatement = "\(statement)\(toAdd)\n);"
        
        return CreateTable(newStatement, numberOfProperties: numberOfProperties + 1)
    }
}
