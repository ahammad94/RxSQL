//
//  SQLExecutable.swift
//  RxSQL
//
//  Created by Hammad, Abdelrahman on 4/20/19.
//

import Foundation
import RxSwift
import SQLite3

public class SQLExecutable {
    private var statmentPointer: OpaquePointer?
    
    internal init(_ statmentPointer: OpaquePointer?) {
        self.statmentPointer = statmentPointer
    }
    
}

extension SQLExecutable {
    public func bindValue(forKey: String, value: SupportedType) -> SQLExecutable {
        value.bind(to: statmentPointer, key: forKey)
        return self
    }
    
    
}

extension SQLExecutable {
    public func execute(db: DatabaseReference?) -> Single<SQLResult> {
        return Single.create { [weak self] singleEvent in
            
            // Evaluate the SQL Statement
            let result = sqlite3_step(self?.statmentPointer)
            
            // If result was a simple done then propage
            if result == SQLITE_DONE {
                singleEvent(.success(SQLDone(self?.statmentPointer)))
            } else if result == SQLITE_ROW {
                singleEvent(.success(SQLRowReference(self?.statmentPointer)))
            } else {
                singleEvent(.error(RxSQLError.errorEvaluatingStatement))
            }
            
            return Disposables.create { sqlite3_finalize(self?.statmentPointer) }
        }
    }
}


