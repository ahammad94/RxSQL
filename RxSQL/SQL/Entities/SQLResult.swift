//
//  SQLResult.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public protocol SQLResult {
    var statmentPointer: OpaquePointer? { get set }
    init(_ statementPointer: OpaquePointer?)
}
