//
//  Float.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

extension Float: SupportedType {
    public func bind(to pointer: OpaquePointer?, key: String) {
        let location = sqlite3_bind_parameter_index(pointer, (key as NSString).utf8String)
        sqlite3_bind_double(pointer, Int32(location), Double(self))
    }
    
    public static func toSql() -> String {
        return "REAL"
    }
    
    public static func valueFrom(_ sqlStatement: OpaquePointer?, col: Int32) -> SupportedType {
        let val = sqlite3_column_double(sqlStatement, col)
        return Float(val)
    }
}
