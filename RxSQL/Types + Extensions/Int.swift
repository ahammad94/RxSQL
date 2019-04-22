//
//  Int.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

extension Int: SupportedType {
    
    public func bind(to pointer: OpaquePointer?, key: String) {
        let location = sqlite3_bind_parameter_index(pointer, (key as NSString).utf8String)
        sqlite3_bind_int(pointer, Int32(location), Int32(self))
    }
    
    public static func toSql() -> String {
        return "INT"
    }
    
    public static func valueFrom(_ sqlStatement: OpaquePointer?, col: Int32) -> SupportedType {
        return Int(sqlite3_column_int(sqlStatement, col))
    }
}
