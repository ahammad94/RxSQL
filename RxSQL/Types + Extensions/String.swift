//
//  String.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

extension String: SupportedType {
    public func bind(to pointer: OpaquePointer?, key: String) {
        let location = sqlite3_bind_parameter_index(pointer, (key as NSString).utf8String)
        let string = self as NSString
        sqlite3_bind_text(pointer, Int32(location), string.utf8String, -1, nil)
    }
    
    public static func toSql() -> String {
        return "CHAR(255)"
    }
    
    public static func valueFrom(_ sqlStatement: OpaquePointer?, col: Int32) -> SupportedType {
        let queryResultCol1 = sqlite3_column_text(sqlStatement, col)
        return String(cString: queryResultCol1!)
    }
}
