//
//  DatabaseReference.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import SQLite3

public class DatabaseReference {
    internal var dbPointer: OpaquePointer?
    
    init(path: URL) {
        var db: OpaquePointer? = nil
        let path = (path.relativePath as NSString).utf8String
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            dbPointer = db
        } else {
            fatalError("Could not open database")
        }
    }
}
