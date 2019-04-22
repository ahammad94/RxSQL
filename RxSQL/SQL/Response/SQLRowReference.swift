//
//  SQLRowReference.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import RxSwift
import SQLite3

public class SQLRowReference: SQLResult {
    public var statmentPointer: OpaquePointer?
    
    init(_ statementPointer: OpaquePointer?) {
        self.statmentPointer = statementPointer
    }
    
    func evaluate() -> Single<[SQLRow]> {
        return Single.create(subscribe: { [weak self] (singleEvent) -> Disposable in
            var rows = [SQLRow]()
            rows.append(SQLRow(statement: self?.statmentPointer))
            
            while sqlite3_step(self?.statmentPointer) == SQLITE_ROW {
                rows.append(SQLRow(statement: self?.statmentPointer))
            }
            
            singleEvent(.success(rows))
            return Disposables.create { }
        })
    }
}
