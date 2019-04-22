//
//  SQLRow.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/21/19.
//

import Foundation
import SQLite3
import RxSwift

public class SQLRow {
    private var values = [String: SupportedType]()
    
    init(statement: OpaquePointer?) {
        self.setup(from: statement)
    }
    
    subscript(index: String) -> SupportedType? {
        get { return values[index] }
    }
    
    
    /// Creates the mapping from coloumn names to column value
    ///
    /// - Parameter statmentPointer: Opaque pointer of the row
    private func setup(from statmentPointer: OpaquePointer?) {
        let numberOfColumns = sqlite3_column_count(statmentPointer)
        
        (0..<numberOfColumns).forEach {
            if let namePointer = sqlite3_column_name(statmentPointer, $0) {
                
                if let name = String(utf8String: namePointer) {
                    let type = colType(statmentPointer, colNumber: $0)
                    let value = type.valueFrom(statmentPointer, col: $0)
                    values[name] = value
                }
            }
        }
    }
    
    
    /// Determines the type of values supported by the column
    ///
    /// - Parameters:
    ///   - statemenfPointer: Opaque pointer of sql statement
    ///   - colNumber: The column to be supported
    /// - Returns: Type of data in column
    private func colType(_ statemenfPointer: OpaquePointer?, colNumber: Int32) -> SupportedType.Type {
        let type = sqlite3_column_type(statemenfPointer, Int32(colNumber))
        
        if type == SQLITE_INTEGER { return Int.self }
        if type == SQLITE_FLOAT { return Float.self }
        return String.self
    }
}
