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
        
        CreateTable("Teachers")
            .setProperty("Id", type: Int.self, canBeNull: false, isPrimaryKey: true, autoIncrement: true)
            .setProperty("Name", type: String.self, canBeNull: false)
            .setProperty("Salary", type: Float.self, canBeNull: false)
            .executable(db: databaseReference)
            .execute(db: databaseReference, SQLDone.self)
            .flatMap { _ in
                CreateTable("Students")
                    .setProperty("Id", type: Int.self, canBeNull: false, isPrimaryKey: true, autoIncrement: true)
                    .setProperty("TeacherId", type: Int.self, canBeNull: false)
                    .setProperty("Name", type: String.self, canBeNull: false)
                    .executable(db: self.databaseReference)
                    .execute(db: self.databaseReference, SQLDone.self)
            }
            .flatMap { _ in
                Insert(into: "Teacher")
                    .properties(["Name", "Salary"])
                    .executable(db: self.databaseReference)
                    .bindValue(forKey: "Name", value: "John")
                    .bindValue(forKey: "Salary", value: Float(485.5))
                    .execute(db: self.databaseReference, SQLDone.self)
            }
            .flatMap { _ in
                Select("*")
                    .from("Teachers")
                    .innerJoin("Students")
                    .using("id")
                    .where("Teachers.salary >= 5000")
                    .executable(db: self.databaseReference)
                    .execute(db: self.databaseReference, SQLRow.self)
            }.subscribe(onSuccess: { (rows) in
                rows.forEach {
                    print("Teacher name is \($0["Name"] as? String)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    class Te: DatabaseEntity { }
}
