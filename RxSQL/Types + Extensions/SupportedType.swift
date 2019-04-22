//
//  SupportedType.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public protocol SupportedType {
    func bind(to pointer: OpaquePointer?, key: String)
    static func toSql() -> String
    static func valueFrom(_ sqlStatement: OpaquePointer?, col: Int32) -> SupportedType
}
