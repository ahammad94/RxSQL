//
//  RxSQLTests.swift
//  RxSQLTests
//
//  Created by Hammad, Abdelrahman on 4/9/19.
//

import XCTest
import RxSwift
@testable import RxSQL

class RxSQLTests: XCTestCase {
    
    var databaseReference = DatabaseReference(path: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    var disposeBag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreatingTable() {
        
        CreateTable(Te.self)
            .setProperty("Id", type: String.self, canBeNull: false, isPrimaryKey: true)
            .setProperty("Name", type: String.self, canBeNull: true)
            .executable(db: databaseReference)
            .execute(db: databaseReference)
            .subscribe()
            .disposed(by: disposeBag)
        
        Insert(into: Te.self)
            .properties(["Id", "Time"])
            .executable(db: databaseReference)
            .bindValue(forKey: "id", value: "123")
            .bindValue(forKey: "time", value: "234")
            .execute(db: databaseReference)
            .subscribe()
            .disposed(by: disposeBag)
        
        Select("*")
            .from("Students")
            .crossJoin("Teachers")
            .on("Students.id == Teachers.id")
            .executable(db: databaseReference)
            .execute(db: databaseReference)
            .subscribe(onSuccess: { (result) in
                if let rows = result as? [SQLRow] {
                    rows.forEach {
                        print($0["id"])
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    class Te: DatabaseEntity { }
}
