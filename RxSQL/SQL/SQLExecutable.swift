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
    public func execute<T: SQLResult>(db: DatabaseReference?, _ returnType: T.Type) -> Single<[T]> {
        return Single.create { [weak self] singleEvent in
            
            // Evaluate the SQL Statement
            let result = sqlite3_step(self?.statmentPointer)
            
            // If result was a simple done then propage
            if result == SQLITE_DONE {
                
                guard returnType == SQLDone.self else {
                    singleEvent(.error(RxSQLError.badReturnTypePassed))
                    return Disposables.create { }
                }
                
                singleEvent(.success([T(self?.statmentPointer)]))
            } else if result == SQLITE_ROW {
                
                // Ensure the expected return type is a row
                guard returnType == SQLRow.self else {
                    singleEvent(.error(RxSQLError.badReturnTypePassed))
                    return Disposables.create { }
                }
                
                // Evaluate all the rows into SQLRows
                var rows = [T(self?.statmentPointer)]
                while sqlite3_step(self?.statmentPointer) == SQLITE_ROW { rows.append(T(self?.statmentPointer)) }
                
                
                singleEvent(.success(rows))
            } else {
                singleEvent(.error(RxSQLError.errorEvaluatingStatement))
            }
            
            return Disposables.create { sqlite3_finalize(self?.statmentPointer) }
        }
    }
    
    
    
}


