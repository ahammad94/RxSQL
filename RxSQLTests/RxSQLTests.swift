//
//  RxSQLTests.swift
//  RxSQLTests
//
//  Created by Hammad, Abdelrahman on 4/9/19.
//

import XCTest
import RxSwift
import RxBlocking
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
        
        Delete()
            .from("Teacher")
            .where("Teacher.salary <= 200")
            .executable(db: databaseReference)
            .execute(db: databaseReference, SQLDone.self)
            .subscribe()
            .disposed(by: disposeBag)
        
       let result =  CreateTable("Teachers")
            .setProperty("Id", type: Int.self, canBeNull: false, isPrimaryKey: true, autoIncrement: true)
            .setProperty("Name", type: String.self, canBeNull: false)
            .setProperty("Salary", type: Float.self, canBeNull: false)
            .executable(db: databaseReference)
            .execute(db: databaseReference, SQLDone.self)
            .toBlocking()
            .materialize()
    
        
        switch result {
        case .failed(elements: _, error: let error):
            XCTFail(error.localizedDescription)
        default:
            break
        }
        
    }
    
    class Te: DatabaseEntity { }
}
